# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Signups do
      let(:client) { NgpVan::Client.new }

      describe '#signup_statuses' do
        let(:params) do
          {
            eventTypeId: 143_856
          }
        end

        let(:response) { fixture('signup_statuses.json') }
        let(:url) { build_url(client: client, path: 'signups/statuses') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.signup_statuses(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of signup_statuses' do
          signup_statuses = client.signup_statuses(params: params)
          expect(signup_statuses).to be_a(Array)
        end

        it 'returns the requested signup statuses statuses' do
          signup_statuses = client.signup_statuses(params: params)
          expect(signup_statuses.first['name']).to eq('Completed')
        end
      end

      describe '#signup' do
        let(:params) { {} }
        let(:response) { fixture('signup.json') }
        let(:url) { build_url(client: client, path: 'signups/2452') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.signup(id: 2_452, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a signup object' do
          signup = client.signup(id: 2_452, params: params)
          expect(signup).to be_a(Hash)
        end

        it 'returns the requested signup' do
          signup = client.signup(id: 2_452, params: params)
          expect(signup['eventSignupId']).to eq(2_452)
        end
      end

      describe '#signups' do
        let(:params) do
          {
            vanId: '100476252',
            '$expand' => 'printedLists,minivanExports',
            hasPrintedList: true,
            hasMinivanExport: true
          }
        end

        let(:response) { fixture('signups.json') }
        let(:url) { build_url(client: client, path: 'signups') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.signups(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of signups' do
          signups = client.signups(params: params)
          expect(signups['items']).to be_a(Array)
        end

        it 'returns the requested signup statuses statuses' do
          signups = client.signups(params: params)
          expect(signups['items'].first['eventSignupId']).to eq(2_452)
        end
      end

      describe '#create_signup' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/create_signup.json"))
        end

        let(:url) { build_url(client: client, path: 'signups') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '2452',
              status: 201,
              headers: {
                'Location' => build_url(client: client, path: '/signups/2452')
              }
            )
        end

        it 'requests the correct resource' do
          client.create_signup(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          expect(client.create_signup(body: body)).to eq(2452)
        end
      end

      describe '#update_signup' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/update_signup.json"))
        end

        let(:url) { build_url(client: client, path: 'signups/2452') }

        before do
          stub_request(:put, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.update_signup(id: 2_452, body: body)
          expect(
            a_request(:put, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.update_signup(id: 2_452, body: body)).to eq('')
        end
      end

      describe '#delete_signup' do
        let(:url) { build_url(client: client, path: 'signups/2452') }

        before do
          stub_request(:delete, url)
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.delete_signup(id: 2_452)
          expect(
            a_request(:delete, url)
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.delete_signup(id: 2_452)).to eq('')
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
