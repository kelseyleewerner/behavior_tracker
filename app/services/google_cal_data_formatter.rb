class GoogleCalDataFormatter
    attr_reader :tracker_type

    def initialize(google_calendar)
        @tracker_type = google_calendar.calendar_title
    end
end