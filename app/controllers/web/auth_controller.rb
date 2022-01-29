# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth_user_info = auth[:info]

    user = User.find_or_initialize_by(email: auth_user_info[:email].downcase)
    user.name = auth_user_info[:name]

    if user.save
      sign_in user
      redirect_to root_path, notice: t('notice.auth.sign_in')
    else
      redirect_to new_user_registration_url
    end
  end

  def destroy
    sign_out
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
