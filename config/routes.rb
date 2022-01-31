# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users, controllers: { omniauth_callbacks: 'web/omniauth_callbacks' }
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
  delete 'auth', to: 'web/auth#destroy', as: :sign_out

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :web do
    root 'home#index'
    get '/registration', to: 'registration#index', as: :new_user_registration

    resources :bulletins, except: :destroy do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace 'admin', as: 'admin' do
      root 'bulletins#index'

      resources :bulletins, only: %i[index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end

      resources :categories
      resources :users, except: %i[create show new]
    end

    scope 'profile' do
      root 'profile/home#index', as: :profile
    end
  end
end
