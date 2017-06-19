class LikesController < ApplicationController
  before_action :user_authorized, only: [:create]
  def create
      like = Like.create(secret: Secret.find(like_params[:secret]), user: current_user)
      redirect_to :back
  end
  def destroy
    Like.find_by(user: current_user, secret: Secret.find(like_params[:secret])).destroy
		redirect_to '/secrets'
  end
  private
    def like_params
      params.require(:like).permit(:secret)
    end
end
