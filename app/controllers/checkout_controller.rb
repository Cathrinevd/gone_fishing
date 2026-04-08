class CheckoutController < ApplicationController
  before_action :authenticate_user!, only: %i[show place_order]
  before_action :load_provinces, only: :show

  def show
    session[:cart] ||= {}
    cart_ids = session[:cart].keys

    @products = Product.where(id: cart_ids)

    missing_ids = cart_ids.map(&:to_s) - @products.pluck(:id).map(&:to_s)
    missing_ids.each { |id| session[:cart].delete(id) }

    @subtotal = @products.sum do |product|
      product.price * session[:cart][product.id.to_s].to_i
    end

    if params[:province_id].present?
      @province = Province.find(params[:province_id])
      @tax = @subtotal * @province.total_tax_rate
    else
      @tax = 0
    end

    @total = @subtotal + @tax
  end

  def place_order
    return redirect_to new_user_session_path, alert: "Please log in first." unless current_user

    user = current_user

    session[:cart] ||= {}
    cart_ids = session[:cart].keys

    @products = Product.where(id: cart_ids)

    subtotal = @products.sum do |product|
      product.price * session[:cart][product.id.to_s].to_i
    end

    if params[:province_id].blank?
      return redirect_to checkout_path, alert: "Please select a province."
    end

    province = Province.find(params[:province_id])
    tax = subtotal * province.total_tax_rate
    total = subtotal + tax

    address = Address.create!(
      user:        user,
      province:    province,
      street:      params[:street],
      city:        params[:city],
      postal_code: params[:postal_code],
      country:     params[:country]
    )

    order = Order.create!(
      user:         user,
      address:      address,
      status:       "paid",
      subtotal:     subtotal,
      tax_amount:   tax,
      total_amount: total
    )

    @products.each do |product|
      OrderItem.create!(
        order:             order,
        product:           product,
        quantity:          session[:cart][product.id.to_s],
        price_at_purchase: product.price
      )
    end

    session[:cart] = {}

    redirect_to products_path, notice: "Order placed successfully! Total: $#{total.round(2)}"
  end

  private

  def load_provinces
    @provinces = Province.order(:name)
  end
end
