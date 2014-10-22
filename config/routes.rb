  Informaticacomp::Application.routes.draw do
  resources :kardexes

  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login
  post 'add_to_home'=> 'products#add_to_home'
  post 'delete_from_home'=> 'products#delete_from_home'
  get 'view_product' => 'products#view_product'
  get 'products_home' => 'products#products_home'
  post 'products_home' => 'products#products_home'
  get 'add_to_home' => 'products#add_to_home'
  get 'delete_from_home' => 'products#delete_from_home'

  get 'destroyer' => 'productorders#destroyer'
  get 'technical_services/report_search' => 'technical_services#report_search'
  get 'egresos' => 'sales#egresos'
  get 'servicios' => 'technical_services#servicios'
  get 'inventario' => 'products#inventario'

  post 'edit_order' => 'productorders#edit_order'
  get 'edit_order' => 'productorders#edit_order'

  post 'ver_pedido' => 'orders#mostrar'
  get 'ver_pedido' => 'orders#mostrar'

  post 'update_order' => 'productorders#update_order'
  get 'update_order' => 'productorders#update_order'

  get 'registrar_ingreso' => 'products#registrar_ingreso'

  get 'income' => 'products#income'
  post 'income' => 'products#income'

  get '/income/index'=> 'income#index'
  
  get 'products/kardex/:id' => 'products#kardex'

  get 'clients/search' => 'clients#search'

  get 'edit_to_home' => 'products#edit_to_home'
  post 'edit_to_home' => 'products#edit_to_home'
  get 'agregar_subproducto_venta' => 'productsales#agregar_subproducto_venta'
  post 'agregar_subproducto_venta' => 'productsales#agregar_subproducto_venta'
  get 'eliminar_subproducto_venta' => 'productsales#eliminar_subproducto_venta'
  post 'eliminar_subproducto_venta' => 'productsales#eliminar_subproducto_venta'
  get 'confirm_sale' => 'sales#confirm_sale'
  post 'confirm_sale' => 'sales#confirm_sale'

  get 'cancel_sale' => 'sales#cancel_sale'
  post 'cancel_sale' => 'sales#cancel_sale'


  get 'products/search' => 'products#search'
  get 'orders/search' => 'orders#search'
  get 'providers/search' => 'providers#search'

  get 'brands/search' => 'brands#search'
  get 'categories/search' => 'categories#search'
  get 'productnames/search' => 'productnames#search'

  get 'products/search_to_home' => 'products#search_to_home'

  get 'sales/search' => 'sales#search'
  get 'sales/searchProduct' => 'sales#searchProduct'
  get 'sales/searchDate' => 'sales#searchDate'

  get 'sales/search_between_dates' => 'sales#search_between_dates'
  get 'sales/report_search' => 'sales#report_search'
  #get 'sales/weekly_report' => 'sales#weekly_report'
  #get 'sales/monthly_report' => 'sales#monthly_report'
  #get 'sales/anual_report' => 'sales#anual_report'

  get 'kardexes/index/:id' => 'kardexes#index'

  root  'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/mision', to: 'static_pages#mision', via: 'get'
  match '/vision', to: 'static_pages#vision', via: 'get'
  match '/confianza', to: 'static_pages#confianza', via: 'get'
  match '/proveedores', to: 'static_pages#proveedores', via: 'get'
  match '/historia', to: 'static_pages#historia', via: 'get'
  


  get 'eliminar_producto_pedido' => 'productorders#eliminar_producto_pedido'
  post 'eliminar_producto_pedido' => 'productorders#eliminar_producto_pedido'


  get 'technical_services/search' => 'technical_services#search'
  get 'technical_services/report_search' => 'technical_services#report_search'
  get 'technical_services/searchNumber' => 'technical_services#searchNumber'
  get 'technical_services/search_between_dates' => 'technical_services#search_between_dates'

  get 'incomes/search' => 'incomes#search'
  get 'incomes/report_search' => 'incomes#report_search'
  get 'incomes/search_between_dates' => 'incomes#search_between_dates'

  get 'outflows/search' => 'outflows#search'
  get 'outflows/report_search' => 'outflows#report_search'
  get 'outflows/search_between_dates' => 'outflows#search_between_dates'

  get 'add_product_sale' => 'productsales#registrar'

  get 'products/search_home' => 'products#search_home'

  #get 'static_pages' => ''

  resources :products do    
    resources :subproducts
  end

  resources :orders do
    resources :productorders  
  end
  
  resources :sales do
    resources :productsales
  end

  resources :sales do
    resources :clients
  end

  resources :productorders  
  resources :sales
  resources :sessions
  resources :users
  resources :incomes
  resources :technical_services  
  resources :categories
  resources :productnames
  resources :brands
  resources :providers
  resources :clients
  resources :outflows
  resources :productsales
  resources :kardexes
  #resources :sales do
   # resources :subproducts
  #end

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
