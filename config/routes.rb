ActionController::Routing::Routes.draw do |map|

  map.root :controller => "characters", :action => "index"

  map.resources :characters do |character|
    character.resources :merits
    character.resources :skills
    character.resources :contracts
  end

  map.merit_dot_range 'merits/:merit_id/dot_range.:format', :controller => 'merits', :action => 'dot_range', :conditions => { :method => :get }
  map.skill_dot_range 'skills/:skill_id/dot_range.:format', :controller => 'skills', :action => 'dot_range', :conditions => { :method => :get }
  map.contract_dot_range 'contracts/:contract_id/dot_range.:format', :controller => 'contracts', :action => 'dot_range', :conditions => { :method => :get }

  ## Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'

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
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

end
