class CartController < ApplicationController
  def show
    session[:cart] ||= []
    @products = Product.find(session[:cart])
  end

  def add
    session[:cart] ||= []
    session[:cart] << params[:id].to_i

    redirect_to cart_path, notice: "Product added to cart."
  end
end
