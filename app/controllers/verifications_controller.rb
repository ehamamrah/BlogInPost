class VerificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :send_token_for_verification, only: %i[generate_new_otp]

  def new
    # If user authy is enabled, it will send token for verifications
    if current_user.authy_enabled?
      current_user.send_token_for_verification
    else
      flash.now[:error] = t(:verification_is_required)
    end
  end

  def create
    # Verify if user is authorized
    request_authy_validation

    if @request.success?
      # Change post to published
      @post.publish
      flash.now[:success] = t(:post_published)
      redirect_to post_path(@post)
    else
      flash.now[:error] = @request.errors.first.pop
      render :new, params: { post_id: @post.id }
    end
  end

  def generate_new_otp
    # Generating new OTP and sending it to user
    flash[:success] = t(:otp_sent)
    render :new, params: { post_id: @post.id }
  end

  private

  def send_token_for_verification
    current_user.send_token_for_verification
  end

  def request_authy_validation
    @request = Authy::API.verify(id: current_user.authy_id, token: params[:token])
    @request
  end

  def find_post
    @post = Post.friendly.find(params[:post_id])
  end
end
