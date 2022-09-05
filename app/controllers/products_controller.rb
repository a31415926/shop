class ProductsController < ApplicationController

  before_action :set_product, only: %i[show edit destroy update]

  def index
    @sort = {
      :new => 'От новых к старым',
      :old => 'От старых к новым',
    }
    field_sort = products_sort(params[:sort])
    @pagy, @products = pagy(Product.all.order(field_sort), items: 12)

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

  def products_sort(sort)
    case sort
    when 'old' #вначале старые
      field_sort = {created_at: :asc}
    when 'new' #вначале новые
      field_sort = {created_at: :desc}
    else 
      field_sort = {created_at: :desc}
    end
  end
end
