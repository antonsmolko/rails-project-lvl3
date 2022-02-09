# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    authorize Category
    @categories = Category.all.page params[:page]
  end

  def new
    @category = Category.new
    authorize Category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save!
      redirect_to admin_categories_path, notice: t('notice.categories.created')
    else
      render :new
    end
  end

  def edit
    @category = resource
    authorize @category
  end

  def update
    authorize resource
    if resource.update!(category_params)
      redirect_to admin_categories_path, notice: t('notice.categories.updated')
    else
      render :new
    end
  end

  def destroy
    @category = resource
    authorize @category
    @category.bulletins.clear
    @category.destroy!

    redirect_to admin_categories_path, notice: t('notice.categories.deleted')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def resource
    Category.find(params[:id])
  end
end
