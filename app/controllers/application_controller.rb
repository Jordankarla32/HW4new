class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    Rails.logger.debug "Session User ID: #{session[:user_id].inspect}" # Debug log
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
