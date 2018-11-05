class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Compte créé pour #{@user.first_name}"
      log_in(@user)
      redirect_to root_path
    else
      render "new"
    end
  end

  def index
    unless logged_in?
      flash[:info] = "Merci de vous connecter, petit malin..."
      redirect_to login_path
    end
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
