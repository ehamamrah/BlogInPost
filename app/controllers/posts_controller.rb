class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource

  def create
    if @post.save
      flash[:success] = t(:successfully_created)
      redirect_to posts_path(@post)
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = t(:successfully_updated)
      redirect_to posts_path(@post)
    else
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t(:deleted_successfully)
    else
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content).merge(category_id: params[:category_id], user: current_user)
  end
end
