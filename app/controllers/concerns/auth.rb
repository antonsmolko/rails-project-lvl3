# frozen_string_literal: true

module Auth
  # def banned?
  #   if current_or_guest_user.banned? # rubocop:disable Style/GuardClause
  #     sign_out current_user
  #     flash[:error] = t('.banned')
  #     redirect_to root_path
  #   end
  # end

  def admin_signed_in?
    current_user.admin? if current_user
  end

  def authenticate_admin!
    return if admin_signed_in?
    redirect_to root_path, notice: t('forbidden')
  end
end
