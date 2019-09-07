namespace :google_calendar do
    task update_database: :environment do
        require "external_api/google_calendar/google_calendar_api"
        googleCal = GoogleCalendarApi.new GOOGLE_CALENDAR_SERVICE, "k9070ltqiesv4p1et6g1ao6774@group.calendar.google.com"
        googleCal.fetch_calendar_title
        googleCal.fetch_calendar_events

        formattedGoogleCal = GoogleCalDataFormatter.new googleCal
        # puts formattedGoogleCal.events[0][:summary]
        
        SaveCalToDatabase.new(formattedGoogleCal).update_database
    end
end


# Exercise Tracker ID
# "s445mshit9o9givlu4gkinrn80@group.calendar.google.com"
# TEST CALENDAR ID
# "k9070ltqiesv4p1et6g1ao6774@group.calendar.google.com"

# NOTES
# want to be able to use this command to get data and move to database
# want to be idempotent

# QUESTIONS
# better ways to do update and delete???
# all new classes i made might need garbage collectors?


# then third class to actually save that formatted data into the database
# class lives in the services folder in the app directory
# will be called in the rake task - will automatically be required for me in task & make new instances in rake task
# things to google: "save data to database rails", "active record 'create' method", "active record find_or_create or find_or_new or find (one of these will make it idempotent)"
# this will interact w the model...somehow
# UPDATE
# DELETE
# NEED TO HANDLE ERROR IF VALIDATION ERRORS when saving to model


# need to add validations to formatter so don't try to set data fields for empty calendar - maybe raises error?