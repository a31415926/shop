class Products::SortProductsQuery < ApplicationQuery
  def initialize(products, params)
    @products = products
    @params = params
  end

  def call
    sort_by_price
    sort_by_date
    sort_by_categories

    @products
  end

  private
  def sort_by_price
    @products = @products.order(price: @params[:price]) if @params[:price].present?
    @products = @products.where('price >= ?', @params[:min_price]) if @params[:min_price].present?
    @products = @products.where('price <= ?', @params[:max_price]) if @params[:max_price].present?

    @products
  end

  def sort_by_date
    return @products unless @params[:created_at].present?

    @products = @products.order(created_at: @params[:created_at])
  end 

  def sort_by_categories
    return @products unless @params[:categories].present?

    @products = @products.joins(:categories).where(categories: { id: @params[:categories]})
  end
end