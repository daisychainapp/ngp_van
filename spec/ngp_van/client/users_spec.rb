# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe Users do
      let(:client) { NgpVan::Client.new }

      describe '#user_district_field_values' do
        let(:params) { {} }
        let(:response) { fixture('user_district_field_values.json') }

        let(:url) do
          build_url(client: client, path: 'users/1234/districtFieldValues')
        end

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.user_district_field_values(id: 1234, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns district field values for a user' do
          results = client.user_district_field_values(id: 1234, params: params)
          expect(results).to be_a(Hash)
        end

        it 'returns the requested district field values' do
          results = client.user_district_field_values(id: 1234, params: params)
          expect(results['districtFieldValues'].first).to eq('W1P2')
        end
      end

      describe '#create_user_district_field_values' do
        let(:body) do
          JSON.parse(
            File.read("#{fixture_path}/create_user_district_field_values.json")
          )
        end

        let(:response) { fixture('user_district_field_values.json') }

        let(:url) do
          build_url(client: client, path: 'users/12345/districtFieldValues')
        end

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.create_user_district_field_values(id: 12_345, body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the user district field value assignments' do
          results = client.create_user_district_field_values(id: 12_345,
                                                             body: body)
          expect(results['districtFieldValues'].first).to eq('W1P2')
        end
      end

      describe '#update_user_district_field_values' do
        let(:body) do
          JSON.parse(
            File.read("#{fixture_path}/update_user_district_field_values.json")
          )
        end

        let(:response) { fixture('user_district_field_values.json') }

        let(:url) do
          build_url(client: client, path: 'users/12345/districtFieldValues')
        end

        before do
          stub_request(:put, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.update_user_district_field_values(id: 12_345, body: body)
          expect(
            a_request(:put, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the user district field value assignments' do
          results = client.update_user_district_field_values(id: 12_345,
                                                             body: body)
          expect(results['districtFieldValues'].first).to eq('W1P2')
        end
      end
    end
  end
end
