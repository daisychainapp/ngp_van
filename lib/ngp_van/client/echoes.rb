# frozen_string_literal: true

module NgpVan
  class Client
    module Echoes
      def echoes(message:)
        post(path: 'echoes', body: { message: message })
      end
    end
  end
end
