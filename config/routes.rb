Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  resources :games, only: [:new, :create, :show, :update, :index] do
    post "forfeit", on: :member
  end
  resources :pieces, only: [:create, :show, :edit, :update]
end
