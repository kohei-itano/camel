Rails.application.routes.draw do
  devise_for :admins, controllers: {
  	registrations: 'admins/registrations',
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  namespace :admin do
  	resources :genres
	end


  devise_for :users, controllers: {
  	registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :users do
		resource :relationships, only: [:create, :destroy]
		get :follows, on: :member
		get :followers, on: :member
	end

	resources :posts do
	  resource :favorites, only: [:create, :destroy]
	  resources :post_comments, only: [:create, :destroy]
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  get 'about' => 'homes#about'
end
