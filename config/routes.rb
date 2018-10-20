Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'static_pages#home'

  get '/thanks' => 'static_pages#thanks', as: :thanks
  get '/pricing' => 'static_pages#pricing', as: :pricing
  get '/about' => 'static_pages#about', as: :about
  get '/faq' => 'static_pages#faq', as: :faq

  get '/response_page' => 'static_pages#response_page', as: :response_page

  get 'users/:id' => 'users#show', as: :user_profile
  get 'users/:id/pic' => 'users#new', as: :user_avatar
  post 'users/:id/pic' => 'users#create'
  # delete '/listings/:id/proposals/' => 'proposals#destroy', as: :proposals_delete

  resources :guests, only: [:index, :show]
  resources :listings do
    resources :proposals, only: [:update, :destroy]
  end

  resources :users do
  resources :messages, only: [:create, :index]
  end

  resources :notifications, only: [:update, :index, :destroy]

  resource :proposals
  resource :map, only: [:show]
  resources :jobs, only: [:show, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
