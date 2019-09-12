namespace :google_calendar do
    task update_database: :environment do
        require "external_api/google_calendar/google_calendar_api"
        googleCal = GoogleCalendarApi.new GOOGLE_CALENDAR_SERVICE, "k9070ltqiesv4p1et6g1ao6774@group.calendar.google.com"
        googleCal.fetch_calendar_title
        googleCal.fetch_calendar_events
        formattedGoogleCal = GoogleCalDataFormatter.new googleCal
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

# TO DO IN FUTURE
# NEED TO HANDLE ERROR IF VALIDATION ERRORS when saving to model
# need to add validations to formatter so don't try to set data fields for empty calendar - maybe raises error?