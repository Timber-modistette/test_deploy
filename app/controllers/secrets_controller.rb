class SecretsController < ApplicationController
  before_action :user_authorized, only: [:index, :create]
  def index
    user = current_user
    @secrets_desc = Secret.joins("left join likes on secrets.id = likes.secret_id").select("secrets.*, count(likes.id) as likes_count").group("secrets.id").order("likes_count DESC")
    @secrets_user_likes = user.secrets_liked_ids
  end
  def create
    secret = Secret.create(secret_params.merge(user: User.find(secret_params[:user])))
    if secret.save
      redirect_to :back, notice: 'successfully created secret'
    else
      flash[:errors] = secret.errors.full_messages
      redirect_to :back
    end
  end
  def destroy
    secret = Secret.find(params[:id])
    secret.destroy
    redirect_to :back
  end
  private
  def secret_params
    params.require(:secret).permit(:content, :user)
  end
end
