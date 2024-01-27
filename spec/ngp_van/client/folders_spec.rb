# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe Folders do
      let(:client) { NgpVan::Client.new }

      describe '#folders' do
        let(:response) { fixture('folders.json') }
        let(:url) { build_url(client: client, path: 'folders') }

        before do
          stub_request(:get, url)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.folders
          expect(
            a_request(:get, url)
          ).to have_been_made
        end

        it 'returns an array of items' do
          folders = client.folders
          expect(folders['items']).to be_a(Array)
        end

        it 'returns the requested folders' do
          folders = client.folders
          expect(folders['items'].first['folderId']).to eq(44)
        end
      end

      describe '#folder' do
        let(:params) { {} }
        let(:response) { fixture('folder.json') }
        let(:url) { build_url(client: client, path: 'folders/44') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.folder(id: 44, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a folder object' do
          folder = client.folder(id: 44, params: params)
          expect(folder).to be_a(Hash)
        end

        it 'returns the requested folder' do
          folder = client.folder(id: 44, params: params)
          expect(folder['folderId']).to eq(44)
        end
      end
    end
  end
end
