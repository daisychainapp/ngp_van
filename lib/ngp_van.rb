# frozen_string_literal: true

require 'ngp_van/client'
require 'ngp_van/configuration'
require 'ngp_van/version'

module NgpVan
  class Invalid < StandardError; end

  class InvalidID < Invalid; end

  class << self
    def client
      @client ||= NgpVan::Client.new
    end

    # Delegate methods called on NgpVan to the client.
    def method_missing(method_name, **args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, **args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name) || super
    end
  end

  # The current configuration.
  # @return [NgpVan::Configuration]
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set new configuration
  # @param config [NgpVan::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify the current configuration
  # @yieldparam [NgpVan::Configuration] config The current NgpVan config
  # ```
  # NgpVan.configure do |config|
  #   config.application_name = 'CroninAndSons'
  #   config.api_key = 'af263f2a-86fd-443b-a1b6-f5b7bce8db30|1'
  # end
  # ```
  def self.configure
    yield configuration
  end
end
