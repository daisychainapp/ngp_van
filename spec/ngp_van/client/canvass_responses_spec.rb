# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe CanvassResponses do
      let(:client) { NgpVan::Client.new }

      describe '#canvass_responses_contact_types' do
        let(:params) do
          {
            inputTypeId: 11
          }
        end

        let(:response) { fixture('canvass_responses_contact_types.json') }

        let(:url) do
          build_url(client: client, path: 'canvassResponses/contactTypes')
        end

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.canvass_responses_contact_types(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of contact types' do
          contact_types = client.canvass_responses_contact_types(params: params)
          expect(contact_types).to be_a(Array)
        end

        it 'returns the requested contact types' do
          contact_types = client.canvass_responses_contact_types(params: params)
          expect(contact_types.first['name']).to eq('Phone')
        end
      end

      describe '#canvass_responses_input_types' do
        let(:params) { {} }
        let(:response) { fixture('canvass_responses_input_types.json') }

        let(:url) do
          build_url(client: client, path: 'canvassResponses/inputTypes')
        end

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.canvass_responses_input_types(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of input types' do
          input_types = client.canvass_responses_input_types(params: params)
          expect(input_types).to be_a(Array)
        end

        it 'returns the requested input type' do
          input_types = client.canvass_responses_input_types(params: params)
          expect(input_types.first['name']).to eq('API')
        end
      end

      describe '#canvass_responses_result_codes' do
        let(:params) do
          {
            inputTypeId: 14,
            contactTypeId: 1
          }
        end

        let(:response) { fixture('canvass_responses_result_codes.json') }

        let(:url) do
          build_url(client: client, path: 'canvassResponses/resultCodes')
        end

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.canvass_responses_result_codes(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of result codes' do
          result_codes = client.canvass_responses_result_codes(params: params)
          expect(result_codes).to be_a(Array)
        end

        it 'returns the requested result codes' do
          result_codes = client.canvass_responses_result_codes(params: params)
          expect(result_codes.first['name']).to eq('Busy')
        end
      end
    end
  end
end
