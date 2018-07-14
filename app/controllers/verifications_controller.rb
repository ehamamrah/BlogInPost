class VerificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[create generate_new_otp]

  def new; end

  def create
    @request = Authy::API.verify(id: current_user.authy_id, token: params[:token])
    if @request.success?
      @post.publish
      flash.now[:success] = t(:post_published)
      redirect_to post_path(@post)
    elsif @request.success == false && @request.try(:error_code).present?
      flash.now[:error] = t(:used_token)
      render :new, params: { post_id: @post.id }
    else
      flash.now[:error] = t(:wrong_token)
      render :new, params: { post_id: @post.id }
    end
  end

  def generate_new_otp
    @post.send_token_for_verification
    flash[:success] = t(:otp_sent)
    render :new, params: { post_id: @post.id }
  end

  private

  def find_post
    @post = Post.friendly.find(params[:post_id])
  end
end
