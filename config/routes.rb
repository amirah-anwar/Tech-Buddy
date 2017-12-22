Rails.application.routes.draw do
  resources :buddyships
  devise_for :users

  resources :users do
    collection do
      get "search_result"
    end
  end

  root 'users#index'
end
