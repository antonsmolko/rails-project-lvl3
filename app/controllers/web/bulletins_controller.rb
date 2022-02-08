# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  helper_method :resource_bulletin

  def index
    @query = Bulletin.published.ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end

  def new
    @bulletin = Bulletin.new
    @categories = Category.all

    authorize Bulletin
  end

  def create
    authorize Bulletin

    if current_user.bulletins.create!(bulletin_params)
      redirect_to profile_path, notice: t('notice.bulletins.created')
    else
      render :new
    end
  end

  def show; end

  def edit
    authorize resource_bulletin
  end

  def update
    authorize resource_bulletin

    if resource_bulletin.update(bulletin_params)
      redirect_to profile_path, notice: t('notice.bulletins.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    authorize resource_bulletin

    resource_bulletin.to_moderate!
    redirect_to profile_path, notice: t('notice.bulletins.to_moderation')
  end

  def archive
    authorize resource_bulletin

    resource_bulletin.archive!
    redirect_to profile_path, notice: t('notice.bulletins.archived')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end

  def resource_bulletin
    @resource_bulletin ||= Bulletin.find(params[:id])
  end
end
