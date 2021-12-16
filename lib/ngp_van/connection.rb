# frozen_string_literal: true

require 'ngp_van/response/raise_error'
require 'faraday_middleware'

module NgpVan
  module Connection
    private

    # rubocop:disable Metrics/MethodLength
    def connection
      options = {
        url: config.api_endpoint,
        headers: {
          'Accept' => 'application/json; charset=utf-8',
          'User-Agent' => config.user_agent
        }
      }

      Faraday::Connection.new(options) do |connection|
        connection.request :basic_auth, config.application_name, config.api_key

        connection.request(:json)
        connection.use NgpVan::Response::RaiseError
        connection.adapter(Faraday.default_adapter)
      end
    end
  end
end
