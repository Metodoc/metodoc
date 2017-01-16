# Load the Rails application.
require_relative 'application'

#Format date 
Time::DATE_FORMATS[:created_at] = "%d/%m/%Y"
Time::DATE_FORMATS[:deadline] = "%d/%m/%Y"
# Initialize the Rails application.
Rails.application.initialize!
