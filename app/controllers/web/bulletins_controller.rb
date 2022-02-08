# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  # TODO: rework it with Pundit policy
  before_action :require_signed_in_user!, except: %i[index show]
  before_action :signed_in_creator?, only: %i[update to_moderate archive]

  helper_method :resource_bulletin

  def index
    @query = Bulletin.published.ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end

  def new
    @bulletin = Bulletin.new
    @categories = Category.all
  end

  def create
    if current_user.bulletins.create!(bulletin_params)
      redirect_to profile_path, notice: t('notice.bulletins.created')
    else
      render :new
    end
  end

  def show; end

  def edit
    resource_bulletin
  end

  def update
    if resource_bulletin.update(bulletin_params)
      redirect_to profile_path, notice: t('notice.bulletins.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    resource_bulletin.to_moderate!
    redirect_to profile_path, notice: t('notice.bulletins.to_moderation')
  end

  def archive
    resource_bulletin.archive!
    redirect_to profile_path, notice: t('notice.bulletins.archived')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end

  def resource_bulletin
    @resource_bulletin = Bulletin.find(params[:id])
  end

  # TODO: move to AuthManagement
  def signed_in_creator?
    return if resource_bulletin.user.id == current_user.id

    redirect_to root_path, notice: t('forbidden')
  end
end
