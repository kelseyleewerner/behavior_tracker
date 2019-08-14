namespace :google_calendar do
    task :update_database do
        require_relative "../external_api/google_calendar/google_calendar.rb"
    end
end

# want to be able to use this command to get data and move to database
# want to be idempotent
# still don't totally understand why doing this as a rake task
