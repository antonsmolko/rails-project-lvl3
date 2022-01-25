# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :require_signed_in_user!, except: %i[index show]
  before_action :signed_in_creator?, only: %i[update to_moderate archive]

  def index
    @query = Bulletin.published.ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end

  def new
    @bulletin = Bulletin.new
    @categories = Category.all
  end

  def create
    @bulletin = Bulletin.new(bulletin_params.merge(user_id: current_user.id))

    if @bulletin.save!
      redirect_to profile_root_path, notice: t('notice.bulletins.created')
    else
      render :new
    end
  end

  def show
    @bulletin = resource
  end

  def edit
    @bulletin = resource
  end

  def update
    if resource.update!(bulletin_params)
      resource.to_draft!
      redirect_to profile_root_path, notice: t('notice.bulletins.updated')
    else
      render :new
    end
  end

  def to_moderate
    resource.to_moderate!
    redirect_to profile_root_path, notice: t('notice.bulletins.to_moderation')
  end

  def archive
    resource.archive!
    redirect_to profile_root_path, notice: t('notice.bulletins.archived')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end

  def resource
    Bulletin.find(params[:id])
  end

  def signed_in_creator?
    return if resource.user.id == current_user.id

    redirect_to root_path, notice: t('forbidden')
  end
end
