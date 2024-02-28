# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe ApiKeyProfiles do
      let(:client) { NgpVan::Client.new }

      describe '#api_key_profiles' do
        let(:response) { fixture('api_key_profiles.json') }

        let(:url) do
          build_url(client: client, path: 'apiKeyProfiles')
        end

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.api_key_profiles
          expect(
            a_request(:get, url)
          ).to have_been_made
        end
      end
    end
  end
end
