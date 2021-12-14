# frozen_string_literal: true

module Auth
  def admin_signed_in?
    current_user.admin? if current_user
  end

  def authenticate_admin!
    return if admin_signed_in?

    redirect_to root_path, notice: t('forbidden')
  end
end
