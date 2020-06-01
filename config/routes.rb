Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users, controllers: {
    sessions: 'user/users/sessions',
    passwords: 'user/users/passwords',
    registrations: 'user/users/registrations',
  }

  scope '/admin' do
    devise_for :admins, controllers: {
      sessions: 'admin/admins/sessions',
    }
  end

  scope module: :user do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :users, only: [:index, :show]
    get '/settings' => 'settings#index'
    get '/settings/profile' => 'settings#settings_profile'
    patch '/settings/profile' => 'settings#update_profile'
    get '/settings/email' => 'settings#settings_email'
    patch '/settings/email' => 'settings#update_email'
    get '/settings/withdraw' => 'settings#settings_withdraw'
    patch '/settings/withdraw' => 'settings#update_withdraw'
    post '/users/:id' => 'users#create_action', as:'create_action'
    patch '/users/:id' => 'users#update_action', as:'update_action'
    get	'/actions/from_partner' => 'actions#from_partner'
    get	'/actions/from_me' => 'actions#from_me'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :actions, only: [:index, :show]
    resources :shops, only: [:new, :create, :index, :show, :edit, :update]
  end
end
