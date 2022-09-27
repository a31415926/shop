class ProductsController < ApplicationController
  require 'net/http'
  require 'json'
  
  before_action :set_product, only: %i[show edit destroy update]

  def index
    products = Product.all
    products = products.order(price: params[:price]) if params[:price].present?
    products = products.order(created_at: params[:created_at]) if params[:created_at].present?
    products = products.joins(:categories).where(categories: { id: params[:categories]}) if params[:categories].present?
    @price_min = products.minimum(:price)
    @price_max = products.maximum(:price)
    @categories = Category.all
    @pagy, @products = pagy(products, items: 12)

  end

  def show; end

  def edit
    @categories = Category.all
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

  def send_product_to_telegram
    product = Product.find(params[:id])

    User.where.not(id_tg: false).each do |user|
      uri = URI("https://api.telegram.org/bot#{ENV['tg_token']}/sendMessage")
      http = Net::HTTP::new(uri.hostname, uri.port)
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = {
        chat_id: user.id_tg,
        text: product.title
      }.to_json
      http.use_ssl = true
      resp = http.request(req)
    end
    redirect_to product_path(product)
  end

  def generate_products
    ProductJob.set(wait: 50.seconds).perform_later
    redirect_to root_path, notice: "Success generate"
  end 

  private

  def product_params
    params.require(:product).permit(:title, :price, :description, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
