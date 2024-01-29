# frozen_string_literal: true

require 'ngp_van/default'
require 'ngp_van/version'

module NgpVan
  class Configuration
    # The Application Name in the NGP VAN system. A short string that identifies
    # your application (e.g., acmeCrmProduct)
    #
    # The `application_name` setting is used for authenticating requests.
    #
    # @return [String, nil]
    attr_accessor :application_name

    # The API Key acquired from NGP VAN. The API Key resembles the concatenation
    # of a GUID, a | and a 0 or 1 (e.g.,
    # bc7b6578-5619-4e8f-92ab-829208e1a511|1).
    #
    # The `api_key` setting is used for authenticating requests.
    #
    # @return [String, nil]
    attr_accessor :api_key

    # The API Endpoint url. Which endpoint you should use is determined by which
    # VAN client with which you're working.
    # @note See http://developers.ngpvan.com/van-api#van-endpoints
    # @return [String]
    attr_accessor :api_endpoint

    # The User-Agent sent to the API endpoint. This defaults to the gem name,
    # suffixed with the current version number.
    # @return [String]
    attr_accessor :user_agent

    def initialize
      setup
    end

    # Reset all configuration to default values.
    # @return [NgpVan::Configuration]
    def reset!
      @application_name = NgpVan::Default.application_name
      @api_key = NgpVan::Default.api_key
      @api_endpoint = NgpVan::Default.api_endpoint
      @user_agent = NgpVan::Default.user_agent
      self
    end

    alias setup reset!

    # Inspect the configuration object, masking private values.
    # @return [String]
    def inspect
      inspected = super

      filter_value!(inspected, NgpVan.configuration.api_key) if NgpVan.configuration.api_key

      filter_value!(inspected, NgpVan.configuration.application_name) if NgpVan.configuration.application_name

      inspected
    end

    private

    def filter_value!(source, str)
      source.gsub!(str, '[FILTERED]')
    end
  end
end
