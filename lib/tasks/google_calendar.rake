namespace :google_calendar do
    task update_database: :environment do
        require "external_api/google_calendar/google_calendar_api"
        googleCal = GoogleCalendarApi.new GOOGLE_CALENDAR_SERVICE, "s445mshit9o9givlu4gkinrn80@group.calendar.google.com"
        googleCal.fetch_calendar_title
        googleCal.fetch_calendar_events

        # p googleCal.calendar_events[0]
        blah = GoogleCalDataFormatter.new googleCal
        p blah.events[0][:date]
        # blah.events.each do |event|
        #     p event[:description]
        # end
    end
end

# gen notes
# want to be able to use this command to get data and move to database
# want to be idempotent

# 1
# then another class that translate the data i get back into the form i want to put into the database
# class lives in the services folder in the app directory
# will be called in the rake task - will automatically be required for me in task & make new instances in rake task

# QUESTIONS
# title of class ok?
# did i even need to save the tracker type? bc it is ok as is...


# 2
# then third class to actually save that formatted data into the database
# class lives in the services folder in the app directory
# will be called in the rake task - will automatically be required for me in task & make new instances in rake task
# things to google: "save data to database rails", "active record 'create' method", "active record find_or_create or find_or_new or find (one of these will make it idempotent)"
# this will interact w the model...somehow


# all new classes i made might need garbage collectors?