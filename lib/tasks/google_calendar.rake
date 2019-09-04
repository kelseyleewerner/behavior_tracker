namespace :google_calendar do
    task update_database: :environment do
        require "external_api/google_calendar/google_calendar_api"
        googleCal = GoogleCalendarApi.new GOOGLE_CALENDAR_SERVICE, "s445mshit9o9givlu4gkinrn80@group.calendar.google.com"
        googleCal.fetch_calendar_title
        googleCal.fetch_calendar_events

        formattedGoogleCal = GoogleCalDataFormatter.new googleCal
        p formattedGoogleCal.events[0][:external_id]
    end
end

# NOTES
# want to be able to use this command to get data and move to database
# want to be idempotent

# QUESTIONS
# title of class ok?
# did i even need to save the tracker type? bc it is ok as is...
# what if i delete the event?
# all new classes i made might need garbage collectors?


# then third class to actually save that formatted data into the database
# class lives in the services folder in the app directory
# will be called in the rake task - will automatically be required for me in task & make new instances in rake task
# things to google: "save data to database rails", "active record 'create' method", "active record find_or_create or find_or_new or find (one of these will make it idempotent)"
# this will interact w the model...somehow
