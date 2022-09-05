class ProductsController < ApplicationController

  before_action :set_product, only: %i[show edit destroy update]

  def index
    products = Product.all
    products = products.order(price: params[:price]) if params[:price].present?
    @pagy, @products = pagy(products, items: 12)

  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    # redirect_to root_path
  end

  def new
    @product = Product.new
  end

  def create
  end

  def generate_products
    ProductJob.perform_later(wait: 5)
    redirect_to root_path, notice: "Success generate"
  end 

  private

  def product_params
    params.require(:product).permit(:title, :description, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
