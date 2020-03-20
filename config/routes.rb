Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
  root to: "top#index"
  resources :users, only: [:show] do
    resources :items, only: [:new, :create] do
      collection do
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
    end
    get "logout" => "users#logout"
    resources :credit_card, only: [:new, :show, :index, :edit] do
      collection do
        post 'pay', to: 'credit_card#pay'
        post 'delete', to: 'credit_card#delete'
        post 'buy/:id', to: 'credit_card#buy'
      end
    end
  end
  resources :top, only: [:show]



  resources :tests, only: [:index, :new, :create,]
  resources :categories, only: [:new, :show, :index]

  
  get "ncard" => "users#ncard"
  get "scard" => "users#scard"
end
