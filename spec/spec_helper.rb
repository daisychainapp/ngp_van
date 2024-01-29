# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'ngp_van'
require 'faker'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
