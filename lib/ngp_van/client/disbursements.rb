# frozen_string_literal: true

module NgpVan
  class Client
    module Disbursements
      def create_or_update_disbursement(body: {})
        post(path: 'disbursements', body: body)
      end

      def disbursement(id:)
        verify_id(id)
        get(path: "disbursements/#{id}")
      end

      def recent_disbursements(params: {})
        get(path: 'disbursements/recentDisbursements', params: params)
      end
    end
  end
end
