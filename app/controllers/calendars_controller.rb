class CalendarsController < ApplicationController
  before_action :current_user, :is_authenticated

  def index
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @calendar_list = service.list_calendar_lists
  rescue Google::Apis::AuthorizationError
    response = client.authorization.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end
end
