# frozen_string_literal: true

module NgpVan
  class Client
    module SavedLists
      def saved_lists(params: {})
        get(path: 'savedLists', params: params)
      end

      def saved_list(id:)
        verify_id(id)
        get(path: "savedLists/#{id}")
      end

      def sms_sync(body: {})
        post(path: "savedLists/smsSync", body: body)
      end
    end
  end
end
