# frozen_string_literal: true

require 'json'

module NgpVan
  module Request
    # Perform an HTTP DELETE request
    def delete(path:, params: {})
      request(method: :delete, path: path, params: params)
    end

    # Perform an HTTP GET request
    def get(path:, params: {})
      request(method: :get, path: path, params: params)
    end

    # Perform an HTTP POST request
    def post(path:, body: {}, headers: {})
      request(method: :post, path: path, body: body, headers: headers)
    end

    # Perform an HTTP PUT request
    def put(path:, body: {}, headers: {})
      request(method: :put, path: path, body: body, headers: headers)
    end

    private

    def request(method:, path:, params: {}, body: {}, headers: {})
      response = connection.send(method) do |request|
        request.path = path
        request.params = params
        request.headers.update(headers) unless headers.empty?
        request.body = ::JSON.generate(body) unless body.empty?
      end

      Response.create(response.body)
    end
  end
end
