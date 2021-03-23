# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'rake', '>= 12.3.3'
gem 'bundler', '>= 1.7', '<= 2.0.1'

group :test, :development do
  gem 'faker', '~> 1.6'
  gem 'byebug'
  gem 'rspec', '~> 3.0'
  gem 'webmock', '~> 1.22'
end

group :test do
  gem 'simplecov', require: false
end
