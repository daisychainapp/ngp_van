# frozen_string_literal: true

module NgpVan
  class Client
    module CanvassFileRequests
      def canvass_file_requests(body: {})
        post(path: 'canvassFileRequests', body: body)
      end

      def canvass_file_request(id:)
        verify_id(id)
        get(path: "canvassFileRequests/#{id}")
      end
    end
  end
end
