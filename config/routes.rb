Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", omniauth_callbacks: "users/omniauth_callbacks"}, skip: [:sessions, :registrations]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session

    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

  resources :users do
    resources :reservations
    resources :trips do
      resources :comments
      resources :reservations
  end
  end

  # You can have the root of your site routed with "root"
  root 'homes#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  post '/trips/form' => 'trips#form'
  post '/trips/matchingtrips' => 'trips#matchingTrips'
  get '/search/trips' => 'trips#search_matching'
  post '/users/:id/createtrips' => 'trips#createTrips'
  patch '/trips/add_coords/:id' => 'trips#updateTripsWithStops'
  get '/users/:id/gettrips' => 'trips#getTrips'
  get '/trips/show/:id' => 'trips#direct_show'
  get '/users/:id/showtrips' => 'trips#showTrips'
  delete '/removeTrip/:id' => 'trips#removeTrip'
  post '/trips/:id/comments' => 'trips#add_comment', as: :trip_comments
  get '/getcomments/:id' => 'comments#send_comments'
  post '/addcomments/:id' => 'comments#add_comments'
   # post '/trips/:id/reserve' => 'reservations#reserve'
   # post '/users/:id/reservations/:id/unreserve' => 'reservations#unreserve'
   # get '/users/:id/reservations/load_all' => 'reservations#load_all'
   # get '/users/:id/trips/:id/load_all_reservations' => 'trips#load_all_reservations'
   # get '/users/:id/tournaments/get_info/:id' => 'tournaments#get_info'


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
