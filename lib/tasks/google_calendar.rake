namespace :google_calendar do
    task :update_database do
        require_relative "../external_api/google_calendar/google_calendar.rb"
    end
end

# have a class that calls the api, then another class that translate the data i get back into the form i want to put into the database, then third class to actually save that formatted data into the database
# want to be able to use this command to get data and move to database
# want to be idempotent

