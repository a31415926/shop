class ProductsController < ApplicationController
  def index
    @sort = {
      :new => 'От новых к старым',
      :old => 'От старых к новым',
    }
    field_sort = products_sort(params[:sort])
    @products = Product.all.order(field_sort)
  end

  def show
    @product = Product.find(params[:id])
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
