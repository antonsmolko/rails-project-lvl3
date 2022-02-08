# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthManagement
  include Pundit

  helper_method :signed_in?, :sign_out

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    redirect_to root_path, alert: t('notice.auth.not_authorized')
  end
end
