class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @bulletins = Bulletin.all
  end

  def new
    @bulletin = Bulletin.create
    @categories = Category.all
  end

  def create
    @bulletin = Bulletin.create(bulletin_params.merge(creator_id: current_user.id))

    if @bulletin.save!
      redirect_to profile_root_path, notice: 'Bulletin was successfully created.'
    else
      render :new
    end
  end

  def show
    @bulletin = resource
  end

  def update
    if resource.update!(bulletin_params)
      redirect_to profile_root_path, notice: 'Bulletin was successfully updated.'
    else
      render :new
    end
  end

  def to_moderate
    resource.to_moderate!
    redirect_to profile_root_path
  end

  def archive
    resource.archive!
    redirect_to profile_root_path
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:name, :description, :category_id, :image)
  end

  def resource
    Bulletin.find(params[:id])
  end
end
