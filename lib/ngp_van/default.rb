# frozen_string_literal: true

require 'ngp_van/version'

module NgpVan
  module Default
    APPLICATION_NAME = nil

    API_KEY = nil

    API_ENDPOINT = 'https://api.securevan.com/v4/'

    USER_AGENT = "NGP VAN Ruby Gem #{NgpVan::VERSION}".freeze

    class << self
      # Default Application Name from {APPLICATION_NAME}
      # @return [String]
      def application_name
        APPLICATION_NAME
      end

      # Default API Key from {API_KEY}
      # @return [String]
      def api_key
        API_KEY
      end

      # Default API Endpoint from {API_ENDPOINT}
      # @return [String]
      def api_endpoint
        API_ENDPOINT
      end

      # Default User Agent from {USER_AGENT}
      # @return [String]
      def user_agent
        USER_AGENT
      end
    end
  end
end
