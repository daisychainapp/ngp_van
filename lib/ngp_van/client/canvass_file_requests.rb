# frozen_string_literal: true

module NgpVan
  class Client
    module CanvassFileRequests
      def canvass_file_requests(body: {})
        post(path: 'canvass_file_requests', body: body)
      end

      def canvass_file_request(id:)
        verify_id(id)
        get(path: "canvass_file_requests/#{id}")
      end
    end
  end
end
