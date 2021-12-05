# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'web/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :web do
    root 'home#index'
    resources :users do
      member do
        get :profile
      end
    end
  end
end
