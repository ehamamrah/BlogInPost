class CommentsController < ApplicationController
  before_action :find_post
  before_action :set_comment, only: %i[show destroy]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      flash[:success] = t(:comment_created)
      redirect_to post_path(@post)
    else
      flash[:error] = @comment.errors.full_messages
      redirect_back fallback_location: post_path(@post)
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t(:comment_deleted)
      redirect_to post_path(@post)
    else
      flash[:error] = t(:something_went_wrong)
      redirect_back fallback_location: post_path(@post)
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def find_post
    @post = Post.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id).merge(user: current_user)
  end
end
