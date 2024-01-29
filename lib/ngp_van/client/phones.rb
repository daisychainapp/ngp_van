# frozen_string_literal: true

module NgpVan
  class Client
    module Phones
      def is_cell_statuses # rubocop:disable Naming/PredicateName
        get(path: 'phones/isCellStatuses')
      end
    end
  end
end
