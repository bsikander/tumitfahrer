Tumitfahrer::Application.routes.draw do

  get 'password_resets/new'

  namespace :api do
    # API v1 Routes
    # uncomment to switch on api v1 (it is depreciated, though)
    # namespace :v1, :defaults => { :format => 'json' } do
    #   resource :search
    #   resources :users do
    #     match '/rides', to: 'rides#get_user_rides', via: :get
    #     resources :rides do
    #       resources :requests
    #     end
    #     resources :devices
    #     resources :ratings
    #     resources :messages
    #   end
    #   resources :rides do
    #     resources :passengers
    #   end
    #   resource :sessions
    #   resources :projects
    # end
    # API v2 Routes
    namespace :v2, :defaults => { :format => 'json' } do
      match '/activities/badges', to: 'activities#get_badge_counter', via: :get
      match "rides_visiom/:ride_id/requests/:id", to: "requests#update_for_visiom", via: 'put'
      match "rides_visiom/:ride_id/requests/:id", to: "requests#destroy_for_visiom", via: 'delete'
      match "/visiom_devices", to: "devices#visiom_devices", via: 'post'
      resources :activities
      resource :forgot
      resource :search
      resource :feedback
      resources :users do
        resources :devices
        resources :ratings
        match '/requests', to: 'requests#get_user_requests', via: :get
        match '/rides', to: 'rides#get_user_rides', via: :get
        resources :rides do
          resources :requests
        end
      end
      match '/rides/ids', to: 'rides#get_ids_existing_rides', via: :get
      resources :rides do
        resources :requests
        resources :conversations do
          resources :messages do
          end
        end
      end
      resource :sessions
    end
  end

  # Web app routes
  resources :users
  resources :password_resets
  resources :rides do
    resources :requests
  end
  resource :sessions, only: [:new, :create, :destroy]

  # Start page route
  root "static_pages#home"
  # Static pages routes
  match "/signup", to: "users#new", via: 'get'
  match "/signin", to: "sessions#new", via: 'get'
  match "/signout", to: "sessions#destroy", via: 'delete'
  match "/help", to: "static_pages#help", via: 'get'
  match "/contact", to: "static_pages#contact", via: 'get'
  match "/contact_us", to: "static_pages#contact_us", via: 'post'
  match "/about", to: "static_pages#about", via: 'get'
  match "/team", to: "static_pages#team", via: 'get'
  match "/privacy", to: "static_pages#privacy", via: 'get'
  match "/terms_and_conditions", to: "static_pages#terms", via: 'get'
  match "/discover", to: "static_pages#discover", via: 'get'
  match "/search_rides", to: "searches#search_rides", via: 'get'
  match "/remove_passenger", to: "rides#remove_passenger", via: 'delete'
  match "/get_picture_from_panoramio", to: "rides#get_picture_from_panoramio", via: 'get'
  match "/update_photo/:id", to: "users#update_photo", via: 'patch'
  match "/timeline", to: "rides#timeline", via: 'get'
  match "/campus", to: "rides#campus" , via: 'get'
  match "/activities", to: "rides#activities" , via:'get'
  match "/my_rides/:id", to: "users#my_rides", via: 'get'
  match "/forgotten_password",to: "password_resets#new", via: 'get'

  #map.check_email "users/check_email", :controller => "users", :action => "check_email"
  #map.resources :users

  #map.resources :users, :collection => { :check_email => :get }


  # HOW TO:

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
end
