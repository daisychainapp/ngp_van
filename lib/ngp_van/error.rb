# frozen_string_literal: true

module NgpVan
  # Custom error class for rescuing from NgpVan errors.
  class Error < StandardError
    attr_reader :body, :response, :status, :errors

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize,
    # rubocop:disable Style/CyclomaticComplexity
    # Returns a NgpVan::Error subclass, depending on status and
    # response message.
    #
    # @param [Hash] response HTTP response
    # @return [NgpVan::Error]
    def self.from_response(response)
      status = response[:status].to_i

      error_klass =
        case status
        when 400 then NgpVan::BadRequest
        when 401 then NgpVan::Unauthorized
        when 403 then NgpVan::Forbidden
        when 405 then NgpVan::MethodNotAllowed
        when 406 then NgpVan::NotAcceptable
        when 408 then NgpVan::RequestTimeout
        when 409 then NgpVan::Conflict
        when 413 then NgpVan::RequestEntityTooLarge
        when 415 then NgpVan::UnsupportedMediaType
        when 422 then NgpVan::UnprocessableEntity
        when 429 then NgpVan::TooManyRequests
        when 404 then NgpVan::NotFound
        when 400..499 then NgpVan::ClientError
        when 500 then NgpVan::InternalServerError
        when 501 then NgpVan::NotImplemented
        when 502 then NgpVan::BadGateway
        when 503 then NgpVan::ServiceUnavailable
        when 504 then NgpVan::GatewayTimeout
        when 500..599 then NgpVan::ServerError
        end

      error_klass&.new(response)
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize,
    # rubocop:enable Style/CyclomaticComplexity

    def initialize(response = nil)
      @response = response
      @body = ::JSON.parse(response[:body])
      @status = response[:status]
      @errors = body.delete('errors')

      super(build_error)
    end

    private

    def build_error
      return nil if response.nil?

      {
        status: status,
        errors: errors
      }
    end
  end

  # Errors in the 400-499 range
  class ClientError < Error; end

  # 400 Bad request
  class BadRequest < ClientError; end

  # 401 Unauthorized
  class Unauthorized < ClientError; end

  # 403 Forbidden
  class Forbidden < ClientError; end

  # 404 Not found
  class NotFound < ClientError; end

  # 405 Method not allowed
  class MethodNotAllowed < ClientError; end

  # 406 Not acceptable
  class NotAcceptable < ClientError; end

  # 408 Request timeout
  class RequestTimeout < ClientError; end

  # 409 Conflict
  class Conflict < ClientError; end

  # 413 Request entity too large
  class RequestEntityTooLarge < ClientError; end

  # 415 Unsupported media type
  class UnsupportedMediaType < ClientError; end

  # 422 Unprocessable entity
  class UnprocessableEntity < ClientError; end

  # 429 Too many requests
  class TooManyRequests < ClientError; end

  # Errors in the 500-599 range
  class ServerError < Error; end

  # 500 Internal server error
  class InternalServerError < ServerError; end

  # 501 Not implemented
  class NotImplemented < ServerError; end

  # 502 Bad gateway
  class BadGateway < ServerError; end

  # 503 Service unavailable
  class ServiceUnavailable < ServerError; end

  # 504 Gateway timeout
  class GatewayTimeout < ServerError; end
end
