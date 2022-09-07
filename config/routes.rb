Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "products#index"

  resources :products do
    resources :order_items, only: %i[create update destroy]
    collection do 
      post 'generate_products', as: :fetch
    end
  end

  resources :orders do
    collection do
      get 'basket'
    end
  end

end
