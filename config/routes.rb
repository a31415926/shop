Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "products#index"

  resources :products do
    resources :order_items, only: %i[create update destroy]
    collection do 
      post 'generate_products', as: :fetch
      get 'send_product_to_telegram/:id' => :send_product_to_telegram
    end
  end

  resources :orders do
    collection do
      get :basket
      get :checkout
    end
  end

  get 'telegram_auth', to: 'telegram#auth'

end
