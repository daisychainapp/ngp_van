# frozen_string_literal: true

module NgpVan
  class Client
    module Targets
      def targets(params: {})
        get(path: 'targets', params: params)
      end

      def target(id:, params: {})
        verify_id(id)
        get(path: "targets/#{id}", params: params)
      end
    end
  end
end
