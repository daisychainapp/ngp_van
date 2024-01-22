# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  # rubocop:disable Metrics/ClassLength
  class Client
    RSpec.describe Targets do
      let(:client) { NgpVan::Client.new }

      describe '#targets' do
        let(:params) do
          {
            status: 'Setup',
            type: 'Static',
            top: 35,
            expand: 'subgroups'
          }
        end
        let(:response) { fixture('targets.json') }
        let(:url) { build_url(client: client, path: 'targets') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.targets(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          targets = client.targets(params: params)
          expect(targets['items']).to be_a(Array)
        end

        it 'returns the requested targets' do
          targets = client.targets(params: params)
          expect(targets['items'].first['targetId']).to eq(15880)
        end
      end

      describe '#target' do
        let(:params) { Hash.new }
        let(:response) { fixture('target.json') }
        let(:url) { build_url(client: client, path: 'targets/15880') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.target(id: 15880, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a target object' do
          target = client.target(id: 15880, params: params)
          expect(target).to be_a(Hash)
        end

        it 'returns the requested target' do
          target = client.target(id: 15880, params: params)
          expect(target['targetId']).to eq(15880)
        end
      end
    end
  end
end
