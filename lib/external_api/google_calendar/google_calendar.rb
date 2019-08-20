require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "date"
require "fileutils"

OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Behavior Tracker".freeze
CREDENTIALS_PATH = "lib/external_api/google_calendar/credentials.json".freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = "lib/external_api/google_calendar/token.yaml".freeze
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Fetch all Exercise Tracker events
calendar_id = "s445mshit9o9givlu4gkinrn80@group.calendar.google.com"
response = service.list_events(calendar_id,
                               single_events: true,
                               order_by:      "startTime")
# puts "Upcoming events:"
# puts "No upcoming events found" if response.items.empty?
# response.items.each do |event|
#   start = event.start.date_time
#   puts "- #{event.summary} (#{start})"
#   puts "end time: #{event.end.date_time}"
# end

# # Fetch all Professional Development Tracker events
# calendar_id = "du558t22rgdvudpp2jsig48c2c@group.calendar.google.com"
# response = service.list_events(calendar_id,
#                                single_events: true,
#                                order_by:      "startTime")
# puts "Upcoming events:"
# puts "No upcoming events found" if response.items.empty?
# response.items.each do |event|
#   start = event.start.date || event.start.date_time
#   puts "- #{event.summary} (#{start})"
# end



class GoogleCalendarApi
  attr_reader :google_calendar_service, :calendar_id, :calendar_title, :calendar_events
  
  def initialize(google_calendar_service, calendar_id)
    @google_calendar_service = google_calendar_service
    @calendar_id = calendar_id
  end

  def fetch_calendar_title
    @calendar_title = google_calendar_service.get_calendar(@calendar_id).summary
  end

  def fetch_calendar_events
    @calendar_events = google_calendar_service.list_events(calendar_id, single_events: true, order_by: "startTime").items
  end
end


googleCal = GoogleCalendarApi.new service, "s445mshit9o9givlu4gkinrn80@group.calendar.google.com"
puts googleCal.calendar_id
puts "-----------------------------------------------------"
googleCal.fetch_calendar_title
puts googleCal.calendar_title
puts "-----------------------------------------------------"
googleCal.fetch_calendar_events
pp googleCal.calendar_events
