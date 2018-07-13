class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource

  def show
    check_category_status
    # get published posts in specific category
    @category_posts = @category.posts.published
    # get most recent posts for the category
    @recent = @category.posts.recent.order('RANDOM()').limit(15)
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
    else
      # Flash error when trying to destroy a category that have posts
      flash[:alert] = t(:cannot_remove_category_associated_with_posts)
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :status)
  end

  def check_category_status
    # return user to main page if category is archived or inactive
    return if @category.active?
    redirect_to root_path
  end
end
