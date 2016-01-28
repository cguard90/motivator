# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

require 'JSON'
require 'httparty'
require 'awesome_print'
require 'pry-rails'

def get_some_data(action, param_name, param_value)
  token = ENV['GIVE_API_TOKEN']
  puts token
  url = "https://app.place2give.com/Service.svc/give-api?token=#{token}&format=json&action=#{action}&PageNumber=1&NumPerPage=100&#{param_name}=#{param_value}"
  response = HTTParty.get(url)
  return response.parsed_response
end

  hash = JSON.parse(get_some_data("searchCharities", "keyword", "animals"))
  ap hash
