class EventsController < ApplicationController
  before_action :current_user, :is_authenticated

  def index
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @events = service.list_events(params[:calendar_id])
    @calendar_list = service.list_calendar_lists
    @events = @events.items.map do |event|
      {
        :title => event.summary,
        :start => event.start.date_time,
        :end => event.end.date_time
      }
    end
    gon.events = @events
  rescue Google::Apis::AuthorizationError
    response = client.refresh!
    session[:authorization] = session[:authorization].merge(response)
    retry
  end

  def create
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    # @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    new_event = Event.new(event_params)

    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event_params[:start],
        time_zone: 'America/Los_Angeles'),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event_params[:end],
        time_zone: 'America/Los_Angeles'),
      summary: new_event.title
    })

    service.insert_event(event_params[:calendar_id], event)

    redirect_to events_url(calendar_id: event_params[:calendar_id])
  end

  def new
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    @client = client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @calendar_list = service.list_calendar_lists
  end

  private

    def event_params
      params.permit(:title, :description, :start, :end, :calendar_id)
    end

end
