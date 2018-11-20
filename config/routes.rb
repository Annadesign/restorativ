Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	root to: 'posts#index'

   	get '/admin' => 'admin/sessions#new'
  	get '/login' => 'admin/sessions#index'
  	get '/logout' => 'admin/sessions#destroy'

  	get 'admin/images/list' => 'admin/images#list'
  	get 'admin/photos/list' => 'admin/photos#list'

	namespace :admin do
		resources :dashboard, only: [:index]
		resources :sessions, only: [:index, :create, :destroy]
		resources :moderators, only: [:index, :new, :create, :edit, :update]
		resources :articles do
      collection do
        patch :reorder
      end
    end
		#resources :services, only: [:index, :new, :create, :edit, :update, :destroy]
		#resources :projects, only: [:index, :new, :create, :edit, :update, :destroy]
		#resources :partners, only: [:index, :new, :create, :edit, :update, :destroy]
		#resources :contacts, only: [:index, :new, :create, :edit, :update, :destroy]
    #resources :faqs, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :sections do
      collection do
        patch :reorder
      end
    end
	end
end
