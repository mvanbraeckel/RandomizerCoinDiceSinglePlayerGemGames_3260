class ApplicationController < ActionController::Base
  helper_method :current_user, :current_goal_type, :current_goal_coin_descr_hash, :current_goal_die_descr_hash
  before_action :authenticate_user!

  def authenticate_user!
    unless current_user
      redirect_to login_path, notice: 'Please login'
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def current_goal_type
    if session[:goal_type]
      @current_goal_type ||= session[:goal_type]
    else
      @current_goal_type = nil
    end
  end

  def current_goal_coin_descr_hash
    if session[:goal_coin_descr_hash]
      @current_goal_coin_descr_hash ||= session[:goal_coin_descr_hash]
    else
      @current_goal_coin_descr_hash = nil
    end
  end

  def current_goal_die_descr_hash
    if session[:goal_die_descr_hash]
      @current_goal_die_descr_hash ||= session[:goal_die_descr_hash]
    else
      @current_goal_die_descr_hash = nil
    end
  end
end
