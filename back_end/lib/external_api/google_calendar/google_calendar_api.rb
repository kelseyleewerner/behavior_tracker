class GoogleCalendarApi
  attr_reader :google_calendar_service, :calendar_id, :calendar_title, :calendar_events
  
  def initialize(google_calendar_service, calendar_id)
    @google_calendar_service = google_calendar_service
    @calendar_id = calendar_id
  end

  def fetch_calendar_title
    @calendar_title = google_calendar_service.get_calendar(@calendar_id).summary
  end

  def fetch_calendar_events
    @calendar_events = google_calendar_service.list_events(calendar_id, single_events: true, order_by: "startTime").items
  end
end
