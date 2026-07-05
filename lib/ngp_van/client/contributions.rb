# frozen_string_literal: true

module NgpVan
  class Client
    module Contributions
      def create_contribution(body: {})
        post(path: 'contributions', body: body)
      end

      def create_contribution_payment(body: {}, idempotency_key: nil)
        headers = idempotency_key ? { 'Idempotency-Key' => idempotency_key } : {}
        post(path: 'contributions/payments', body: body, headers: headers)
      end

      def recent_contributions(params: {})
        get(path: 'contributions/recentContributions', params: params)
      end

      def contribution(id:)
        verify_id(id)
        get(path: "contributions/#{id}")
      end

      def contribution_by_type(id:, type:)
        verify_ids(id, type)
        get(path: "contributions/#{type}:#{id}")
      end

      def contribution_attribution_types
        get(path: 'contributions/attributionTypes')
      end

      def create_or_update_contribution_attribution(id:, van_id:, body: {})
        verify_ids(id, van_id)
        put(path: "contributions/#{id}/attributions/#{van_id}", body: body)
      end

      def delete_contribution_attribution(id:, van_id:)
        verify_ids(id, van_id)
        delete(path: "contributions/#{id}/attributions/#{van_id}")
      end

      def adjust_contribution(id:, body: {})
        verify_ids(id)
        post(path: "contributions/#{id}/adjustments", body: body)
      end
    end
  end
end
