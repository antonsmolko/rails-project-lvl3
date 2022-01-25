# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all.page params[:page]
  end

  def edit
    @user = resource
  end

  def update
    @user = resource
    @user.assign_attributes(user_params)
    if @user.save(validate: false)
      redirect_to admin_users_path, notice: t('notice.users.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = resource
    @user.bulletins.clear
    @user.destroy!

    redirect_to admin_users_path, notice: t('notice.users.deleted')
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end

  def resource
    User.find(params[:id])
  end
end
