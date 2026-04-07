class CartController < ApplicationController
  before_action :normalize_cart

  def show
    cart_ids = session[:cart].keys

    # Load only existing products
    @products = Product.where(id: cart_ids)

    # Remove non-existing product IDs
    missing_ids = cart_ids.map(&:to_s) - @products.pluck(:id).map(&:to_s)
    missing_ids.each { |id| session[:cart].delete(id) }
  end

  def add
    product_id = params[:id].to_s
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    redirect_to cart_path, notice: "Product added to cart."
  end

  def remove
    session[:cart].delete(params[:id].to_s)
    redirect_to cart_path, notice: "Product removed."
  end

  def update_quantity
    product_id = params[:id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] = quantity
    else
      session[:cart].delete(product_id)
    end

    redirect_to cart_path
  end

  private

  def normalize_cart
    session[:cart] ||= {}

    return unless session[:cart].is_a?(Array)

    new_cart = {}
    session[:cart].each do |product_id|
      key = product_id.to_s
      new_cart[key] ||= 0
      new_cart[key] += 1
    end
    session[:cart] = new_cart
  end
end
