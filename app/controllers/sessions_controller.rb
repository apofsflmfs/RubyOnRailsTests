class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "You are now connected as #{user.first_name}"
      redirect_to user
    else
      flash.now[:danger] = "Invalid combination of email/password"
      render 'new'
    end
  end

  def delete
    log_out
    redirect_to root_path
  end
end
