Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "products#index"

  resources :products do
    resources :products, only: %i[index new create show edit destroy update]
    collection do 
      post 'generate_products', as: :fetch
    end
  end

end
