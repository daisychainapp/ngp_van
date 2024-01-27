# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Codes do
      let(:client) { NgpVan::Client.new }

      describe '#code_supported_entities' do
        let(:params) { Hash.new }
        let(:response) { fixture('code_supported_entities.json') }
        let(:url) { build_url(client: client, path: 'codes/supportedEntities') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.code_supported_entities(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          code_supported_entities = client.code_supported_entities(
            params: params)
          expect(code_supported_entities).to be_a(Array)
        end

        it 'returns a collection of code supported entities' do
          code_supported_entities = client.code_supported_entities(
            params: params)
          expect(code_supported_entities.first).to eq('Contacts')
        end
      end

      describe '#codes' do
        let(:params) do
          {
            parentCodeId: 20_513
          }
        end

        let(:response) { fixture('codes.json') }
        let(:url) { build_url(client: client, path: 'codes') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.codes(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          codes = client.codes(params: params)
          expect(codes['items']).to be_a(Array)
        end

        it 'returns the requested codes' do
          codes = client.codes(params: params)
          expect(codes['items'].first['codeId']).to eq(20_514)
        end
      end

      describe '#code' do
        let(:params) { Hash.new }
        let(:response) { fixture('code.json') }
        let(:url) { build_url(client: client, path: 'codes/20515') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.code(id: 20_515, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a code object' do
          code = client.code(id: 20_515, params: params)
          expect(code).to be_a(Hash)
        end

        it 'returns the requested code' do
          code = client.code(id: 20_515, params: params)
          expect(code['codeId']).to eq(20_515)
        end
      end

      describe '#create_code' do
        let(:body) { JSON.parse(File.read(fixture_path + '/code.json')) }
        let(:url) { build_url(client: client, path: 'codes') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '20516',
              status: 201,
              headers: {
                'Location' => build_url(client: client, path: '/codes/20516')
              }
            )
        end

        it 'requests the correct resource' do
          client.create_code(body: body)
          expect(
            a_request(:post, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns the created id' do
          expect(client.create_code(body: body)).to eq(20516)
        end
      end

      describe '#update_code' do
        let(:body) { JSON.parse(File.read(fixture_path + '/update_code.json')) }
        let(:url) { build_url(client: client, path: 'codes/20516') }

        before do
          stub_request(:put, url)
            .with(body: JSON.generate(body))
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.update_code(id: 20_516, body: body)
          expect(
            a_request(:put, url)
              .with(
                body: body
              )
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.update_code(id: 20_516, body: body)).to eq('')
        end
      end

      describe '#delete_code' do
        let(:url) { build_url(client: client, path: 'codes/20516') }

        before do
          stub_request(:delete, url)
            .to_return(
              body: '',
              status: 204
            )
        end

        it 'requests the correct resource' do
          client.delete_code(id: 20_516)
          expect(
            a_request(:delete, url)
          ).to have_been_made
        end

        it 'returns an empty response body' do
          expect(client.delete_code(id: 20_516)).to eq('')
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
