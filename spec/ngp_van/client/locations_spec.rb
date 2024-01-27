# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Locations do
      let(:client) { NgpVan::Client.new }

      describe '#locations' do
        let(:params) do
          {
            name: 'HQ'
          }
        end

        let(:response) { fixture('locations.json') }
        let(:url) { build_url(client: client, path: 'locations') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.locations(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          locations = client.locations(params: params)
          expect(locations['items']).to be_a(Array)
        end

        it 'returns the requested locations' do
          locations = client.locations(params: params)
          expect(locations['items'].first['locationId']).to eq(272)
        end
      end

      describe '#location' do
        let(:params) { Hash.new }
        let(:response) { fixture('location.json') }
        let(:url) { build_url(client: client, path: 'locations/272') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.location(id: 272, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a location object' do
          location = client.location(id: 272, params: params)
          expect(location).to be_a(Hash)
        end

        it 'returns the requested location' do
          location = client.location(id: 272, params: params)
          expect(location['locationId']).to eq(272)
        end
      end

      describe '#find_or_create_location' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/create_location.json'))
        end

        let(:url) { build_url(client: client, path: 'locations/findOrCreate') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '272',
              status: 201,
              headers: {
                'Location' => build_url(client: client, path: '/locations/272')
              }
            )
        end

        it 'requests the correct resource' do
          client.find_or_create_location(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created code id' do
          expect(client.find_or_create_location(body: body)).to eq(272)
        end
      end

      describe '#create_location' do
        let(:body) do
          JSON.parse(File.read(fixture_path + '/create_location.json'))
        end

        let(:url) { build_url(client: client, path: 'locations') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '272',
              status: 201,
              headers: {
                'Location' => build_url(client: client, path: '/locations/272')
              }
            )
        end

        it 'requests the correct resource' do
          client.create_location(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          expect(client.create_location(body: body)).to eq(272)
        end
      end

      describe '#delete_location' do
        let(:url) { build_url(client: client, path: 'locations/272') }

        before do
          stub_request(:delete, url)
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.delete_location(id: 272)
          expect(
            a_request(:delete, url)
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.delete_location(id: 272)).to eq('')
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
