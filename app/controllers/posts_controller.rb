class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource

  def index
    # if user is superadmin then @posts will get all posts by all users [controlled by ability]
    @posts = @posts.order(created_at: :desc)
  end

  def show
    # Get category related posts
    @related = Post.related_posts(@post.category_id).limit(15)

    # Add impression (one viewer) to post
    impressionist(@post)
  end

  def create
    if @post.save
      flash[:success] = t(:successfully_created)
      # Will redirect to OTP verification page
      redirect_to new_post_verification_path(@post)
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = t(:successfully_updated)
      redirect_to post_path(@post)
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
    end
    redirect_to root_path
  end

  def hide
    # Will hide post if its published
    if @post.hide
      flash[:success] = t(:post_is_hidden_now)
    else
      flash.now[:error] = @post.errors.full_messages
    end
    redirect_back fallback_location: post_path(@post)
  end

  def publish
    # It will republish post if its hidden
    if @post.publish
      flash[:success] = t(:post_published)
    else
      flash.now[:error] = @post.errors.full_messages
    end
    redirect_back fallback_location: post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content).merge(category_id: params[:post][:category_id], user: current_user)
  end
end
