namespace :google_calendar do
    task update_database: :environment do
        require "external_api/google_calendar/google_calendar_api"
        googleCal = GoogleCalendarApi.new GOOGLE_CALENDAR_SERVICE, "s445mshit9o9givlu4gkinrn80@group.calendar.google.com"
        puts googleCal.calendar_id
        puts "-----------------------------------------------------"
        googleCal.fetch_calendar_title
        puts googleCal.calendar_title
        puts "-----------------------------------------------------"
        googleCal.fetch_calendar_events
        pp googleCal.calendar_events
    end
end


# want to be able to use this command to get data and move to database
# want to be idempotent


# then another class that translate the data i get back into the form i want to put into the database
# class lives in the services folder in the app directory
# will be called in the rake task - will automatically be required for me in task & make new instances in rake task



# then third class to actually save that formatted data into the database
# class lives in the services folder in the app directory
# will be called in the rake task - will automatically be required for me in task & make new instances in rake task
# things to google: "save data to database rails", "active record 'create' method", "active record find_or_create or find_or_new or find (one of these will make it idempotent)"
# this will interact w the model...somehow


# all new classes i made might need garbage collectors?