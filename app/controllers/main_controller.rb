class MainController < ApplicationController
  def index
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]
    response = client.fetch_access_token!
    session[:authorization] = response
    redirect_to calendars_url
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    if params[:current_path]
      redirect_to params[:current_path]
    else
      redirect_to client.authorization_uri.to_s
    end
  end

  def signout
    client = nil
    redirect_to root_path
  end

end
