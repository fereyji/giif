ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resource :provider_session, :member => { :create => :get}

  map.resources :orders, :member => {:get_file => :get, :destroy_item => :delete, :send_order => :post }

  map.resources :currencies

  map.resources :users

  map.resources :groups

  map.resources :estimates
  map.resources :estimates do |estimate|
    estimate.resources :files
  end
  
  map.resources :providers

  map.resources :products

  map.resources :order_products

  map.namespace :budget do |budget|
    budget.resource :session
    budget.resources :orders, :member => { :reject => :post}
  end

  map.namespace :acquisition do |acquisition|
    acquisition.resource :session
    acquisition.resources :orders
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "sessions"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
