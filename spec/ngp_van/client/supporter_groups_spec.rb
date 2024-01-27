# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe SupporterGroups do
      let(:client) { NgpVan::Client.new }

      describe '#create_supporter_group' do
        let(:body) do
          JSON.parse(fixture('create_supporter_group.json').read)
        end

        let(:url) { build_url(client: client, path: 'supporterGroups') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '1122',
              status: 201,
              headers: {
                'Location' => build_url(client: client, path: '/supporterGroups/1122')
              }
            )
        end

        it 'requests the correct resource' do
          client.create_supporter_group(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          expect(client.create_supporter_group(body: body)).to eq(1122)
        end
      end

      describe '#supporter_group' do
        let(:response) { fixture('supporter_group.json') }
        let(:url) { build_url(client: client, path: 'supporterGroups/1122') }

        before do
          stub_request(:get, url).to_return(body: response)
        end

        it 'requests the correct resource' do
          client.supporter_group(id: 1122)
          expect(a_request(:get, url)).to have_been_made
        end

        it 'returns a event object' do
          supporter_group = client.supporter_group(id: 1122)
          expect(supporter_group).to be_a(Hash)
        end

        it 'returns the requested supporter group' do
          supporter_group = client.supporter_group(id: 1122)
          expect(supporter_group['id']).to eq(1122)
        end
      end

      describe '#delete_supporter_group' do
        let(:url) { build_url(client: client, path: 'supporterGroups/1122') }

        before do
          stub_request(:delete, url).to_return(status: 204, body: '')
        end

        it 'performs the request' do
          client.delete_supporter_group(id: 1122)
          expect(a_request(:delete, url)).to have_been_made
        end
      end

      describe '#supporter_groups' do
        let(:params) do
          {
            '$top' => 2
          }
        end

        let(:response) { fixture('supporter_groups.json') }
        let(:url) { build_url(client: client, path: 'supporterGroups') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.supporter_groups(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          supporter_groups = client.supporter_groups(params: params)
          expect(supporter_groups['items']).to be_a(Array)
        end

        it 'returns the requested supporter groups' do
          supporter_groups = client.supporter_groups(params: params)
          expect(supporter_groups['items'].first['id']).to eq(1122)
        end
      end

      describe '#add_person_to_supporter_group' do
        let(:url) { build_url(client: client, path: 'supporterGroups/1122/people/3344') }

        before do
          stub_request(:put, url).to_return(status: 204)
        end

        it 'requests the correct resource' do
          client.add_person_to_supporter_group(supporter_group_id: 1122, id: 3344)
          expect(a_request(:put, url)).to have_been_made
        end
      end

      describe '#remove_person_from_supporter_group' do
        let(:url) { build_url(client: client, path: 'supporterGroups/1122/people/3344') }

        before do
          stub_request(:delete, url).to_return(status: 204)

          it 'requests the correct resource' do
            client.add_person_to_supporter_group(supporter_group_id: 1122, id: 3344)
            expect(a_request(:delete, url)).to have_been_made
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
