class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]

  def show
    @category = Category.find_by(slug: params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = 'Category created.'
      redirect_to root_path
    else
      render :new
    end
  end
end
