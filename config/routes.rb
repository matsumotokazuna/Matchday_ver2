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
    resources :users, only: [:index, :show]
    get '/settings' => 'settings#index'
    get '/settings/profile' => 'settings#settings_profile'
    patch '/settings/profile' => 'settings#update_profile'
    get '/settings/email' => 'settings#settings_email'
    patch '/settings/email' => 'settings#update_email'
    get '/settings/withdraw' => 'settings#settings_withdraw'
    patch '/settings/withdraw' => 'settings#update_withdraw'
    post '/users/:id' => 'users#create_activity', as:'create_activity'
    patch '/users/:id' => 'users#update_activity', as:'update_activity'
    get	'/activities/from_partner' => 'activities#from_partner'
    get	'/activities/from_me' => 'activities#from_me'
    get	'/activities/date' => 'activities#date'
    resources :user_schedules, only: [:new, :create, :index, :destroy, :edit, :update]
    resources :activities, only: [:destroy, :update]
    get '/activities/:partner_user_id' => 'activities#show', as:'show_activities'
    get '/activities/:partner_user_id/edit' => 'activities#edit', as:'edit_activities'
    get 'search' => 'search#search'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update] do
      resources :user_schedules, only: [:index]
    end
    resources :activities, only: [:index, :show, :edit, :update, :destroy]
    resources :shops, only: [:new, :create, :index, :show, :edit, :update] do
      resources :shop_schedules, only: [:new, :create, :index, :destroy, :edit, :update]
    end
  end
end
