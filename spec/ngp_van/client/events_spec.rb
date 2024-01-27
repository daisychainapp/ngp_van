# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Events do
      let(:client) { NgpVan::Client.new }

      describe '#create_event' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/create_event.json"))
        end

        let(:url) { build_url(client: client, path: 'events') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '1370',
              status: 201,
              headers: {
                'Location' => build_url(client: client, path: '/events/1370')
              }
            )
        end

        it 'requests the correct resource' do
          client.create_event(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          expect(client.create_event(body: body)).to eq(1370)
        end
      end

      describe '#create_event_shift' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/create_event_shift.json"))
        end

        let(:url) { build_url(client: client, path: 'events/234234/shifts') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '2162',
              status: 201
            )
        end

        it 'requests the correct resource' do
          client.create_event_shift(id: 234_234, body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          expect(
            client.create_event_shift(id: 234_234, body: body)
          ).to eq(2162)
        end
      end

      describe '#event' do
        let(:params) { { '$expand' => 'locations,codes' } }
        let(:response) { fixture('event.json') }
        let(:url) { build_url(client: client, path: 'events/1370') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.event(id: 1_370, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a event object' do
          event = client.event(id: 1_370, params: params)
          expect(event).to be_a(Hash)
        end

        it 'returns the requested event' do
          event = client.event(id: 1_370, params: params)
          expect(event['eventId']).to eq(1_370)
        end
      end

      describe '#events' do
        let(:params) do
          {
            startingAfter: '2015-05-31',
            '$expand' => 'shifts',
            '$top' => 2,
            districtFieldValue: '003'
          }
        end

        let(:response) { fixture('events.json') }
        let(:url) { build_url(client: client, path: 'events') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.events(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          events = client.events(params: params)
          expect(events['items']).to be_a(Array)
        end

        it 'returns the requested events' do
          events = client.events(params: params)
          expect(events['items'].first['eventId']).to eq(1_370)
        end
      end

      describe '#update_event' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/update_event.json"))
        end

        let(:url) { build_url(client: client, path: 'events/1374') }

        before do
          stub_request(:put, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.update_event(id: 1_374, body: body)
          expect(
            a_request(:put, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.update_event(id: 1_374, body: body)).to eq('')
        end
      end

      describe '#delete_event' do
        let(:url) { build_url(client: client, path: 'events/1374') }

        before do
          stub_request(:delete, url)
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.delete_event(id: 1_374)
          expect(
            a_request(:delete, url)
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.delete_event(id: 1_374)).to eq('')
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
