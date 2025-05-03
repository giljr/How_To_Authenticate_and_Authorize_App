Rails.application.routes.draw do
  get "products/index"
  get "products/new"
  get "products/create"
  get "products/edit"
  get "products/update"
  get "products/destroy"
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker



  get 'customers/edit_customer', to: 'customers#edit_customer', as: 'edit_customer'
  post 'customers/manage_customer', to: 'customers#manage_customer', as: 'manage_customer'

  get 'roles/:id/permissions', to: 'roles#permissions', as: 'permissions'
  post 'roles/:id/store_permissions', to: 'roles#store_permissions', as: 'store_permissions'

  get 'dashboard/lock_accounts', to: 'dashboard#lock_accounts', as: 'lock_accounts'
  get 'dashboard/:id/unlock_accounts', to: 'dashboard#unlock_accounts', as: 'unlock_accounts'

  get 'confirm_account_deletion', to: 'accounts#confirm_deletion'
  delete 'delete_account', to: 'accounts#destroy', as: 'delete_account'

  resources :roles
  resources :staff_users
  resources :customers, only: [:edit, :update]
  resources :dashboards, only: [:index]
  resources :products
  # Defines the root path route ("/")
  root "dashboard#index"

end
