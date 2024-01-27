# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe Notes do
      let(:client) { NgpVan::Client.new }

      describe '#note_category_types' do
        let(:params) { {} }
        let(:response) { fixture('note_category_types.json') }
        let(:url) { build_url(client: client, path: 'notes/categoryTypes') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.note_category_types(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          note_category_types = client.note_category_types(params: params)
          expect(note_category_types).to be_a(Array)
        end

        it 'returns the requested note_category_types' do
          note_category_types = client.note_category_types(params: params)
          expect(note_category_types.first).to eq('Person')
        end
      end

      describe '#note_categories' do
        let(:params) { {} }
        let(:response) { fixture('note_categories.json') }
        let(:url) { build_url(client: client, path: 'notes/categories') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.note_categories(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          note_categories = client.note_categories(params: params)
          expect(note_categories).to be_a(Array)
        end

        it 'returns the requested note_categories' do
          note_categories = client.note_categories(params: params)
          expect(note_categories.first['noteCategoryId']).to eq(24)
        end
      end

      describe '#note_category' do
        let(:params) { {} }
        let(:response) { fixture('note_category.json') }
        let(:url) { build_url(client: client, path: 'notes/categories/24') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.note_category(id: 24, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a note category object' do
          note_category = client.note_category(id: 24, params: params)
          expect(note_category).to be_a(Hash)
        end

        it 'returns the requested note_category' do
          note_category = client.note_category(id: 24, params: params)
          expect(note_category['noteCategoryId']).to eq(24)
        end
      end
    end
  end
end
