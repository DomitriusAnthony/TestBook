Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  get 'friends/index'

  get 'friends/destroy'

  resources :friend_requests
	resources :comments do
		resources :comments
	end
  
	resources :posts do
		resources :comments
  	end
  
 	devise_for :users, controllers: { :registrations => "registrations" } do 
    	resources :users, :only => [:show]
  	end
	
	get "/users/:id", to: "users#show", :as => :user
   
	root to: "home#index"

	resources :conversations, only: [:create] do
		member do
			post :close
    	end
    	 resources :messages, only: [:create]
    end
end
