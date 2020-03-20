Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'auth_admin' => 'authentication#authenticate_admin'
      get 'logout' => 'authentication#admin_logout'
      resources :services, exept: [:show]
      get 'service/service_types', to: 'services#service_types'
      get 'get_ticker/:symbol', to: 'search#get_ticker', as: 'get_ticker'
    end
  end
end
