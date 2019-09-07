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
                tracker_type: @tracker_type,
                summary: event.summary,
                description: event.description,
                date: event.start.date_time.to_date,
                duration: event.end.date_time.to_i - event.start.date_time.to_i,
                external_identifier: event.id
            }
            events.push new_event
        end
        events
    end
end