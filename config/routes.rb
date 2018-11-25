Rails.application.routes.draw do
  root "orderings#index"
  
  get 'forgotten_password/new'
  post 'forgotten_password/create'
  get 'forgotten_password/show'
  get 'forgotten_password/reset_password'
  patch 'forgotten_password/update_password'
  
  get 'customer_profile/index'
  get 'customer_profile/edit'
  patch 'customer_profile/update'
  get 'customer_profile/change_password'
  patch 'customer_profile/update_password'
  
  get 'register', to: 'sign_up#new'
  post 'register', to: 'sign_up#create'
  
  get 'login', to: 'login#new'
  post 'login', to: 'login#create'
  
  get '/admin/login', to: 'login#admin_login'
  post '/admin/login', to: 'login#admin_session_id'
  
  delete 'logout', to: 'login#destroy'
  delete '/admin/logout', to: 'login#destroy_admin_id'
 
  resources :payment, only: [ :new, :create, :index ]
  resources :order_history, only: [:index, :show]
  resources :admins
  resources :customers
  resources :menus
  resources :categories
  resources :orders do
    resources :order_items, only: [ :update, :destroy ] do
      collection do
        patch :update_quantities
      end
      
      member do
        delete :delete_order_item
        delete :delete_order_item_at_checkoutpage
      end
    end
    collection do
      post :create_order_items
    end
  end
  resources :orderings, only: [ :index ] do
    collection do
      post :order
      get :checkout
    end
  end
  
  namespace :api do
    resources :menu_items
    resources :order_items, only: [ :index, :update ]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
