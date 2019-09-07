class SaveCalToDatabase
    def initialize(event_list)
        @event_list = event_list.events
    end

    def update_database
        save_to_database
    end

    private

    def save_to_database
        @event_list.each do |event|
            found_event = Event.find_or_create_by(external_identifier: event[:external_identifier]) do |new_event|
                            new_event.tracker_type = event[:tracker_type]
                            new_event.summary = event[:summary]
                            new_event.description = event[:description]
                            new_event.date = event[:date]
                            new_event.duration = event[:duration]
                          end
            found_event.update summary: event[:summary] unless event[:summary] == found_event.summary
            found_event.update description: event[:description] unless event[:description] == found_event.description
            found_event.update date: event[:date] unless event[:date] == found_event.date
            found_event.update duration: event[:duration] unless event[:duration] == found_event.duration
        end
    end
end