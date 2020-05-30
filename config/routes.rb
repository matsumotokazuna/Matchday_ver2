Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    passwords: 'admin/admins/passwords',
    registrations: 'asmin/admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'user/users/sessions',
    passwords: 'user/users/passwords',
    registrations: 'user/users/registrations',
  }

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
    resources :actions, only: [:create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
