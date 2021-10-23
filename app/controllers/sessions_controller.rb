class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "You are logged in."
    else
      flash.now[:alert] = "Your email and password is invalid or does not exist. Please sign up as a new user if you do not have an account set up yet."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You are logged out!"
  end
end
