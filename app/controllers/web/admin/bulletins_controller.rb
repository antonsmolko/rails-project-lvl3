# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @query = Bulletin.where.not(state: :draft).ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end

  def publish
    resource.publish!
    redirect_to admin_root_path, notice: t('notice.bulletins.published')
  end

  def reject
    resource.reject!
    redirect_to admin_root_path, notice: t('notice.bulletins.rejected')
  end

  def archive
    resource.archive!
    redirect_to admin_root_path, notice: t('notice.bulletins.archived')
  end

  private

  def resource
    Bulletin.find(params[:id])
  end
end
