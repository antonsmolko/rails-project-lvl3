class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all.page params[:page]
  end

  def new
    @user= User.new
  end

  def create
    @user= User.new(user_params)

    if @user.save!
      redirect_to admin_users_path, notice: t('notice.users.created')
    else
      render :new
    end
  end

  def edit
    authenticate_super_admin! if resource.super_admin?
    @user = resource
  end

  def update
    @user = resource
    params = @user.super_admin? ? user_params.except(:role) : user_params
    if @user.update!(params)
      redirect_to admin_users_path, notice: t('notice.users.updated')
    else
      render :new
    end
  end

  def destroy
    authenticate_super_admin! if resource.super_admin?

    @user = resource
    @user.bulletins.clear
    @user.destroy!

    redirect_to admin_users_path, notice: t('notice.users.deleted')
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :role)
  end

  def resource
    User.find(params[:id])
  end
end
