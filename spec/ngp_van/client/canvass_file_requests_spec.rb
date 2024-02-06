# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe CanvassFileRequests do
      let(:client) { NgpVan::Client.new }

      describe '#canvass_file_requests' do
        let(:response) { fixture('canvass_file_request.json') }
        let(:url) { build_url(client: client, path: 'canvassFileRequests') }
        let(:body) { { savedListId: 555888, webhookUrl: 'https://webhook.example.org/canvassFileRequests', type: 102 } }

        before do
          stub_request(:post, url)
            .with(body: body)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.canvass_file_requests(body: body)
          expect(
            a_request(:post, url)
          ).to have_been_made
        end

        it 'returns a hash of information' do
          canvass_file_request = client.canvass_file_requests(body: body)
          expect(canvass_file_request).to be_a(Hash)
        end

        it 'returns the status of the generated canvass file request' do
          canvass_file_request = client.canvass_file_requests(body: body)
          expect(canvass_file_request['status']).to eq('Completed')
        end
      end

      describe '#canvass_file_request' do
        let(:response) { fixture('canvass_file_request.json') }
        let(:url) { build_url(client: client, path: 'canvassFileRequests/123') }

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.canvass_file_request(id: 123)
          expect(
            a_request(:get, url)
          ).to have_been_made
        end

        it 'returns a canvass_file_request object' do
          canvass_file_request = client.canvass_file_request(id: 123)
          expect(canvass_file_request).to be_a(Hash)
        end

        it 'returns the requested canvass_file_request' do
          canvass_file_request = client.canvass_file_request(id: 123)
          expect(canvass_file_request['canvassFileRequestId']).to eq(123)
        end
      end
    end
  end
end
