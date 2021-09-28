# frozen_string_literal: true

require 'ngp_van/error'
require 'faraday'

module NgpVan
  module Response
    class RaiseError < Faraday::Response::Middleware
      def on_complete(response)
        error = NgpVan::Error.from_response(response)
        raise error if error
      end
    end
  end
end
