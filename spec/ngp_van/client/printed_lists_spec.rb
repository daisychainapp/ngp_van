# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe PrintedLists do
      let(:client) { NgpVan::Client.new }

      describe '#printed_lists' do
        let(:params) do
          {
            generatedAfter: '2012-10-01',
            generatedBefore: '2012-11-01',
            createdBy: '123',
            folderName: 'GOTV',
            turfName: 'Precinct+1',
            hasSignup: true,
            '$expand' => 'eventSignups'
          }
        end

        let(:response) { fixture('printed_lists.json') }
        let(:url) { build_url(client: client, path: 'printedLists') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.printed_lists(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          printed_lists = client.printed_lists(params: params)
          expect(printed_lists['items']).to be_a(Array)
        end

        it 'returns the requested printed_lists' do
          printed_lists = client.printed_lists(params: params)
          expect(printed_lists['items'].first['number']).to eq('15981815-49117')
        end
      end

      describe '#printed_list' do
        let(:params) { {} }
        let(:response) { fixture('printed_list.json') }

        let(:url) do
          build_url(client: client, path: 'printedLists/15981815-49117')
        end

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.printed_list(id: '15981815-49117', params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a printed_list object' do
          expect(
            client.printed_list(id: '15981815-49117', params: params)
          ).to be_a(Hash)
        end

        it 'returns the requested printed_list' do
          printed_list = client.printed_list(id: '15981815-49117',
                                             params: params)
          expect(printed_list['number']).to eq('15981815-49117')
        end
      end
    end
  end
end
