Rails.application.routes.draw do
  

  resources :users 
  resources :orders
  match '/shipping', to: 'orders#shipping', via: 'get'
  match '/billing', to: 'orders#billing', via: 'get'


  resources :addresses
  
  match '/admin',   to: 'users#admin', via: 'get'
  match '/control_panel', to: 'users#customer', via: 'get'
  match '/signup',  to: 'users#new', via: 'get'

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signin',  to: 'sessions#create', via: 'post'
  match '/signout', to: 'sessions#destroy', via: :delete

  resources :products
  #put '/search', to: 'products#search', via: 'get'

  resource :cart, only: [:show] do
  put 'add/:product_id', to: 'carts#add', as: :add_to
  put 'remove/:product_id', to: 'carts#remove', as: :remove_from
end

  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help' , via: 'get'
  match '/about',   to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/noaccess',to: 'static_pages#no_access', via: 'get'



 
  
end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

