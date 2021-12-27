# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'web/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :web do
    root 'home#index'

    resources :bulletins, except: :destroy do
      member do
        get :to_moderate
        get :archive
      end
    end

    namespace 'admin', as: 'admin' do
      root 'bulletins#index'

      resources :bulletins, only: %i[index] do
        member do
          get :approve
          get :reject
          get :archive
        end
      end

      resources :categories
      resources :users, except: %i[create show new]
    end

    namespace 'profile', as: 'profile' do
      root 'home#index'
    end
  end
end
