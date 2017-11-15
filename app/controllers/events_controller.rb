class EventsController < ApplicationController
  def index
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @events = service.list_events(params[:calendar_id])
    @events = @events.items.map {|event|
      {
        :title => event.summary,
        :start => event.start.date_time,
        :end => event.end.date_time
      }
    }
    gon.events = @events
  rescue Google::Apis::AuthorizationError
    response = client.refresh!
    session[:authorization] = session[:authorization].merge(response)
    retry
  end

  def create
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    data = params[:data]
    puts data
    # today = Date.today
    #
    # event = Google::Apis::CalendarV3::Event.new({
    #   start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
    #   end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
    #   summary: 'New event!'
    # })
    #
    # service.insert_event(params[:calendar_id], event)

    redirect_to events_url(calendar_id: params[:calendar_id])
  end

  def new
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
  end

end
