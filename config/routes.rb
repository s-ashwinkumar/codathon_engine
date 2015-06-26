Codathon::Application.routes.draw do

  get 'login', to: 'application#login', :as => "login"

  match '/logout', to: 'application#logout', :as => "logout"
  match '/admin_home', to: 'admins#home', :as => "admin_home"
  match '/admin_page', to: 'admins#admin_page', :as => "admin_page"
  match '/participant_home', to: 'participants#home', :as => "participant_home"
  match '/create_challenge', to: 'admins#create_challenge', :as => "create_challenge"
  match '/challenge/:id', to: 'challenges#index', :as => "challenge"
  match '/update_challenge', to: 'challenges#update', :as => "update_challenge"
  match '/select_winner', to: 'challenges#select_winner', :as => "select_winner"
  match '/convert_user', to: 'users#convert_to_admin', :as => "convert_user"
  match '/subscribe', to: 'participants#subscribe', :as => "subscription"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'application#home_page'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
