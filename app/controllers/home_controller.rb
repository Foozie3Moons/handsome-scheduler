class HomeController < ApplicationController
  def index
  end
  
  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  private

  def client_options
    {
      client_id: request.env(GOOGLE_CLIENT_KEY),
      client_secret: request.env(GOOGLE_CLIENT_SECRET),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
