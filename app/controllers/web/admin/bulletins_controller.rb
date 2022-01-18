# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @query = Bulletin.where.not(state: :draft).ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end

  def approve
    redirect_to admin_root_path, notice: t('notice.categories.published')
  end

  def reject
    resource.reject!
    redirect_to admin_root_path, notice: t('notice.categories.rejected')
  end

  def archive
    resource.archive!
    redirect_to admin_root_path, notice: t('notice.categories.archived')
  end

  private

  def resource
    Bulletin.find(params[:id])
  end
end
