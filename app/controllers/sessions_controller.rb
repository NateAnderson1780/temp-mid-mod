class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      flash[:notice] = "Email and/or Password is invalid, please try again."
      redirect_to :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_path
  end
end
