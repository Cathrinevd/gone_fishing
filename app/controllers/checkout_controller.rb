class CheckoutController < ApplicationController
  def show
    session[:cart] ||= {}
    @products = Product.find(session[:cart].keys)

    @subtotal = @products.sum do |product|
      product.price * session[:cart][product.id.to_s]
    end

    @province = params[:province]
    @tax = @province.present? ? calculate_tax(@subtotal, @province) : 0
    @total = @subtotal + @tax
  end

  def place_order
    session[:cart] ||= {}
    products = Product.find(session[:cart].keys)

    subtotal = products.sum do |product|
      product.price * session[:cart][product.id.to_s]
    end

    province = params[:province]
    tax = calculate_tax(subtotal, province)
    total = subtotal + tax

    session[:cart] = {}

    redirect_to products_path, notice: "Order placed successfully! Total: $#{total.round(2)}"
  end

  private

  def calculate_tax(subtotal, province)
    case province
    when "MB"
      subtotal * 0.12
    when "ON"
      subtotal * 0.13
    when "AB"
      subtotal * 0.05
    else
      0
    end
  end
end
