class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource

  impressionist actions: %i[show]

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
      redirect_to post_path(@post)
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

  private

  def post_params
    params.require(:post).permit(:title, :description, :content).merge(category_id: params[:post][:category_id], user: current_user)
  end
end
