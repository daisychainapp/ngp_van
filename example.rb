$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'ngp_van'
require 'byebug'

configuration = NgpVan::Configuration.new
configuration.application_name = ENV['APPLICATION_NAME']
configuration.api_key = ENV['API_KEY']
configuration.api_endpoint = ENV['API_ENDPOINT']

client = NgpVan::Client.new(configuration)

byebug

puts "Bye!"
