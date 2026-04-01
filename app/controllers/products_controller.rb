class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 10.minutes.ago)
      @products = @products.order(created_at: :desc)
    elsif params[:filter] == "recently_updated"
      @products = @products.where("updated_at >= ?", 10.minutes.ago)
      @products = @products.order(updated_at: :desc)
    else
      @products = @products.order(created_at: :desc)
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully"
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :brand, :category_id,
                                    :image)
  end
end
