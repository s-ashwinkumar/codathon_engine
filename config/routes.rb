Codathon::Application.routes.draw do
  
  get 'login', to: 'application#login'

  match '/logout', to: 'application#logout'
  match '/dashboards', to: 'dashboards#index', :as => "dashboards"
  match '/average_score_charts', to: 'dashboards#average_score_charts', :as => "average_score_charts"
  match '/engagement_charts', to: 'dashboards#engagement_charts', :as => "engagement_charts"
  match '/individual_score_chart', to: 'dashboards#individual_score_chart', :as => "individual_score_chart"
  match '/challenges', to: 'challenges#index', :as => "challenges"
  match '/practices', to: 'practices#index', :as => "practices"
  match '/challenge/finish', to: 'challenges#finish', :as => "challenge_finish"
  match '/challenge/schedule', to: 'challenges#schedule', :as => "challenge_schedule"
  match '/load_modal', to: 'challenges#load_modal', :as => "load_modal"
  match '/save_challenge', to: 'challenges#save_challenge', :as => "save_challenge"
  match '/load_datepicker', to: 'challenges#load_datepicker', :as => "challenges_load_datepicker"
  match '/index', to: 'challenges#user_index', :as => "user_index"
  match '/challenge/create', to: 'challenges#create', :as =>"create_challenge"

  match '/delete_test_case', to: 'questions#delete_test_case', :as => 'delete_test_case', :via => ['post']


  match '/validate_submission', to: 'submissions#validate_submission', :as => 'validate_submission', :via => ['post']
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
