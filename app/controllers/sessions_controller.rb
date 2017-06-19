class SessionsController < ApplicationController
  layout 'two_column'
  def new

  end
  def create
    @user = User.find_by_email(user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}/show"
    else
      flash[:errors] = ["invalid combination"]
      redirect_to :back
    end
  end
  def destroy
    reset_session
    redirect_to '/'
  end
  private
  def user_params
    params.require(:user).permit(:email,:password)
  end
end
