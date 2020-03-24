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
    get "logout" => "users#logout"
    resources :credit_card, only: [:new, :show, :index, :edit] do
      collection do
        post 'pay', to: 'credit_card#pay'
        post 'delete', to: 'credit_card#delete'
        post 'buy', to: 'credit_card#buy'
      end
    end
  end
  resources :top, only: [:show]


  resources :items, only: [:new, :create, :show, :destroy] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      post 'purchase'
      get 'purchased'

    end
  end

  resources :tests, only: [:index, :new, :create,]
  resources :categories, only: [:new, :show, :index]

  
  get "ncard" => "users#ncard"
end
