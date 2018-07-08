class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @category_posts = @category.posts.published
  end

  def create
    if @category.save
      flash[:success] = t(:successfully_created)
      redirect_to categories_path
    else
      flash.now[:error] = @category.errors.full_messages
      render :new
    end
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = t(:successfully_updated)
      redirect_to categories_path
    else
      flash.now[:error] = @category.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t(:deleted_successfully)
      redirect_to categories_path
    else
      flash.now[:error] = @category.errors.full_messages
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :status)
  end
end
