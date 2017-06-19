class UsersController < ApplicationController

  def new

  end
  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}/show"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end
  def show
    if !session[:user_id]
      redirect_to '/'
    else
      @user_liked = User.find(params[:id]).secrets_liked
      @secrets = Secret.limit(5).order(created_at: :desc)
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.update(params[:id], user_params)
    if user.valid?
      redirect_to "/users/#{session[:user_id]}/show", notice: 'successfully updated'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end
  def destroy
    user = User.find(params[:id]).destroy
    reset_session
    redirect_to '/', notice: 'successfully deleted account'
  end
  private
  def user_params
    params.require(:user).permit(:email,:password,:name,:password_confirmation)
  end
  def user_update_params

  end
end
