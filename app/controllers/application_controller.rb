class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :current_user

  def is_authenticated
    unless current_user
      redirect_to root_path
    end
  end

  def current_user
    if @current_user
      if @current_user.oauth_expires_at < Time.new
        session[:user_id] = nil
        # eventual warning when logged out, currently does nothing
        flash[:warning] = 'You have been logged out due to inactivity'
      end
    end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
    def client_options
      {
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: callback_url
      }
    end
end
