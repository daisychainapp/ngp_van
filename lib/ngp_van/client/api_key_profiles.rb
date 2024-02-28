# frozen_string_literal: true

module NgpVan
  class Client
    module ApiKeyProfiles
      def api_key_profiles
        get(path: 'apiKeyProfiles')
      end
    end
  end
end
