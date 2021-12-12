# frozen_string_literal: true

module Auth
  def admin_signed_in?
    current_user.admin? || super_admin_signed_in? if current_user
  end

  def super_admin_signed_in?
    current_user&.super_admin?
  end

  def authenticate_super_admin!
    return if super_admin_signed_in?

    redirect_to root_path, notice: t('forbidden')
  end

  def authenticate_admin!
    return if admin_signed_in?

    redirect_to root_path, notice: t('forbidden')
  end
end
