class GoogleCalDataFormatter
    attr_reader :tracker_type, :events

    def initialize(google_calendar)
        @tracker_type = google_calendar.calendar_title
        @events = format_events google_calendar
    end

    def format_events(google_calendar)
        events = []
        google_calendar.calendar_events.each do |event|
            new_event = {
                summary: event.summary,
                description: event.description
            }
            events.push new_event
        end
        events
    end
end