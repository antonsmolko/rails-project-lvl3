class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.where.not(aasm_state: :draft)
  end

  def show
    @bulletin = resource
  end

  def approve
    resource.publish!
    redirect_to admin_root_path
  end

  def reject
    resource.reject!
    redirect_to admin_root_path
  end

  def archive
    resource.archive!
    redirect_to admin_root_path
  end

  private

  def resource
    Bulletin.find(params[:id])
  end
end
