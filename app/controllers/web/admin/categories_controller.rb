class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all.page params[:page]
  end

  def show
    @category = resource
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save!
      redirect_to admin_categories_path, notice: t('notice.categories.created')
    else
      render :new
    end
  end

  def edit
    @category = resource
  end

  def update
    if resource.update!(category_params)
      redirect_to admin_categories_path, notice: t('notice.categories.updated')
    else
      render :new
    end
  end

  def destroy
    @category = resource
    @category.bulletins.clear
    @category.destroy!

    redirect_to admin_categories_path, notice: t('notice.categories.deletec')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def resource
    Category.find(params[:id])
  end
end
