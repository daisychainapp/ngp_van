# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe Disbursements do
      let(:client) { NgpVan::Client.new }

      describe '#create_or_update_disbursement' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/create_disbursement.json"))
        end

        let(:response) { fixture('disbursement.json') }
        let(:url) { build_url(client: client, path: 'disbursements') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              status: 201,
              body: response
            )
        end

        it 'requests the correct resource' do
          client.create_or_update_disbursement(body: body)
          expect(
            a_request(:post, url).with(body: body)
          ).to have_been_made
        end

        it 'returns the disbursement' do
          disbursement = client.create_or_update_disbursement(body: body)
          expect(disbursement['disbursementId']).to eq(987654321)
        end
      end

      describe '#disbursement' do
        let(:response) { fixture('disbursement.json') }
        let(:url) { build_url(client: client, path: 'disbursements/987654321') }

        before do
          stub_request(:get, url).to_return(body: response)
        end

        it 'requests the correct resource' do
          client.disbursement(id: 987654321)
          expect(a_request(:get, url)).to have_been_made
        end

        it 'returns a disbursement object' do
          disbursement = client.disbursement(id: 987654321)
          expect(disbursement).to be_a(Hash)
        end

        it 'returns the requested disbursement' do
          disbursement = client.disbursement(id: 987654321)
          expect(disbursement['disbursementId']).to eq(987654321)
        end
      end

      describe '#recent_disbursements' do
        let(:response) { fixture('recent_disbursements.json') }
        let(:params) { { vanId: 215501 } }
        let(:url) { build_url(client: client, path: 'disbursements/recentDisbursements') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(body: response)
        end

        it 'requests the correct resource' do
          client.recent_disbursements(params: params)
          expect(
            a_request(:get, url).with(query: params)
          ).to have_been_made
        end

        it 'returns a list of disbursements' do
          disbursements = client.recent_disbursements(params: params)
          expect(disbursements['items']).to be_a(Array)
        end
      end
    end
  end
end
