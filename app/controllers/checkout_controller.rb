class CheckoutController < ApplicationController
  before_action :load_provinces, only: :show

  def show
    session[:cart] ||= {}
    cart_ids = session[:cart].keys

    # Load only existing products in cart
    @products = Product.where(id: cart_ids)

    # Remove missing products from the session
    missing_ids = cart_ids.map(&:to_s) - @products.pluck(:id).map(&:to_s)
    missing_ids.each { |id| session[:cart].delete(id) }

    # Calculate subtotal
    @subtotal = @products.sum do |product|
      product.price * session[:cart][product.id.to_s].to_i
    end

    # Province and tax lookup
    if params[:province_id].present?
      @province = Province.find(params[:province_id])
      @tax = @subtotal * @province.total_tax_rate
    else
      @tax = 0
    end

    @total = @subtotal + @tax
  end

  # ---------------------------------------------------------
  # PLACE ORDER
  # ---------------------------------------------------------
  def place_order
    session[:cart] ||= {}
    cart_ids = session[:cart].keys

    @products = Product.where(id: cart_ids)

    subtotal = @products.sum do |product|
      product.price * session[:cart][product.id.to_s].to_i
    end

    # Province MUST come from province_id (no more codes in dropdown)
    if params[:province_id].blank?
      return redirect_to checkout_path, alert: "Please select a province."
    end

    province = Province.find(params[:province_id])
    tax = subtotal * province.total_tax_rate
    total = subtotal + tax

    # Create or update user
    user = User.find_or_initialize_by(email: params[:email])
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.password = "password123" if user.new_record?
    user.save!

    # Address
    address = Address.create!(
      user:        user,
      province:    province,
      street:      params[:street],
      city:        params[:city],
      postal_code: params[:postal_code],
      country:     params[:country]
    )

    # Order
    order = Order.create!(
      user:         user,
      address:      address,
      status:       "paid",
      subtotal:     subtotal,
      tax_amount:   tax,
      total_amount: total
    )

    # Order items
    @products.each do |product|
      OrderItem.create!(
        order:             order,
        product:           product,
        quantity:          session[:cart][product.id.to_s],
        price_at_purchase: product.price
      )
    end

    # Clear cart
    session[:cart] = {}

    redirect_to products_path, notice: "Order placed successfully! Total: $#{total.round(2)}"
  end

  private

  def load_provinces
    @provinces = Province.order(:name)
  end
end
