Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about', as: "about"
  
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  get 'customers/mypage', to: 'customers#show', as: 'mypage'
  get 'customers/infomation/edit', to: 'customers#edit'
  patch 'customer/infomation', to: 'customers#update'
  get 'customers/unsubscribe'
  patch 'customers/withdraw'
  resources :addresses, except: [:new, :show]
end

namespace :public do
  resources :items, only: [:index, :show]
end
 
 devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

scope module: :admin do
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, except: [:new, :post, :destroy]
end

namespace :admin do
  resources :items, except: [:destroy]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
