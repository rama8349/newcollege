Rails.application.routes.draw do
 resources :session
controller :session do
 get 'auth/:provider/callback' => 'session#create'
 get 'auth/failure' => redirect('/')
 get 'signout' => 'session#destroy', as: 'signout'
  
end 

  resources :tweets, only: [:new, :create]

controller :tweets do
  get 'tweets/new'     => :new

get 'tweets/search_tweet'     => :search_tweet
get 'tweets'     => :search_tweet
post 'tweets/create' =>:create

 # get 'login/edit/:id' => :edit
end

 

controller :login do
  get 'login/login1'     => :login1
get 'login/login'     => :login
get 'login/logout'   =>:logout
post '/login/authorize' =>:authorize
 # get 'login/edit/:id' => :edit
end
controller :employee do
get 'employee/newemployee'   => :newemployee
get 'employee/showemployee'   => :showemployee
post 'employee/createemployee'   => :createemployee
end

controller :user do
get 'user/login'   => :login
get 'user/new_user'   => :new_user
get 'user/show_user'   => :show_user
get 'user/logout'   => :logout
get 'user/java_script'   => :java_script
get 'user/download_uploaded_documents' => :download_uploaded_documents

post 'user/createuser'   => :createuser
post 'user/uploadFile'   => :uploadFile
post 'user/authorize'   => :authorize


end

controller :admin do
#get 'admin/index'   => :home
get 'admin/index'   => :index
get 'admin/showcountry' =>:showcountry
get 'admin/indexcountry' =>:indexcountry
get 'admin/detailscountry' =>:detailscountry
get 'admin/editcountry' =>:editcountry
get 'admin/indexstate' =>:indexstate
get 'admin/detailsstate' =>:detailsstate
get 'admin/editstate' =>:editstate

get 'admin/newregional' =>:newregional
get 'admin/editregion' =>:editregion

post 'admin/createregion' =>:createregion
post 'admin/updateregion' =>:updateregion


get 'admin/showstate' =>:showstate
get 'admin/showregion' =>:showregion
get 'admin/showcity' =>:showcity
get 'admin/indexcity' =>:indexcity
get 'admin/editcity' =>:editcity
get 'admin/detailscity' =>:detailscity
get 'admin/city_search' =>:city_search

post 'admin/savecity' =>:savecity
post 'admin/updatecity' =>:updatecity

get 'admin/showcollege' =>:showcollege
get 'admin/indexcollege' =>:indexcollege
get 'admin/search_city' =>:search_city
get 'admin/showcollege' =>:showcollege
post 'admin/savecollege' =>:savecollege
post 'admin/updatecollege' =>:updatecollege
get 'admin/editcollege' =>:editcollege
get 'admin/detailscollege' =>:detailscollege

get 'admin/show_assign_user_attendance' =>:show_assign_user_attendance
get 'admin/assign_user_attendance' =>:assign_user_attendance
post 'admin/assign_att' =>:assign_att
get 'admin/show_attendance' =>:show_attendance

post 'admin/savecountry' =>:savecountry
post 'admin/updatecountry' =>:updatecountry
post 'admin/savestate' =>:savestate
post 'admin/updatestate' =>:updatestate



end


resources :employees
resources :users
resources :admins
resources :logins
#root to: 'examples#index'
root to: 'login#index'
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

