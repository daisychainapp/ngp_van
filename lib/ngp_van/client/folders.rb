# frozen_string_literal: true

module NgpVan
  class Client
    module Folders
      def folders
        get(path: 'folders')
      end

      def folder(id:, params: {})
        verify_id(id)
        get(path: "folders/#{id}", params: params)
      end
    end
  end
end
