# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/ModuleLength
module NgpVan
  RSpec.describe Request do
    let(:client) { NgpVan::Client.new }
    let(:params) { { id: 2 } }

    describe '#delete' do
      let(:url) { build_url(client: client, path: '/some/resource') }

      context 'when making a request' do
        before do
          stub_request(:delete, url)
        end

        it 'makes a DELETE request' do
          NgpVan.delete(path: '/some/resource')
          expect(a_request(:delete, url)).to have_been_made
        end
      end

      context 'when passing parameters to the request' do
        before do
          stub_request(:delete, url).with(query: params)
        end

        it 'passes params to the request' do
          NgpVan.delete(path: '/some/resource', params: params)

          expect(a_request(:delete, url).with(query: params))
            .to have_been_made
        end
      end
    end

    describe '#get' do
      let(:url) { build_url(client: client, path: '/some/resource') }

      context 'when making a request' do
        before do
          stub_request(:get, url)
        end

        it 'makes a get request' do
          NgpVan.get(path: '/some/resource')
          expect(a_request(:get, url)).to have_been_made
        end
      end

      context 'when passing parameters to the request' do
        before do
          stub_request(:get, url).with(query: params)
        end

        it 'passes params to the request' do
          NgpVan.get(path: '/some/resource', params: params)

          expect(a_request(:get, url).with(query: params))
            .to have_been_made
        end
      end

      context 'when the response has a non-success status code' do
        before do
          stub_request(:get, url)
            .to_return(status: 404, body: {errors: [{code: 'NOT_FOUND', text: 'it was not found'}]}.to_json)
        end

        it 'raises an appropriate error' do
          expect do
            NgpVan.get(path: '/some/resource')
          end.to raise_error(NgpVan::NotFound)
        end
      end
    end

    describe '#post' do
      let(:url) { build_url(client: client, path: '/some/resource') }
      let(:body) do
        {
          name: 'Neighbors Calling Neighbors',
          shortName: 'NeighborCall',
          description: 'Come help get the word out about our great campaign.'
        }
      end

      context 'when making a request' do
        before do
          stub_request(:post, url)
        end

        it 'makes a post request' do
          NgpVan.post(path: '/some/resource')
          expect(a_request(:post, url)).to have_been_made
        end
      end

      context 'when passing a body to the request' do
        before do
          stub_request(:post, url).with(body: JSON.generate(body))
        end

        it 'passes body to the request' do
          NgpVan.post(path: '/some/resource', body: body)

          expect(a_request(:post, url).with(body: JSON.generate(body)))
            .to have_been_made
        end
      end
    end

    describe '#put' do
      let(:url) { build_url(client: client, path: '/some/resource') }
      let(:body) do
        {
          name: 'Neighbors Calling Neighbors',
          shortName: 'NeighborCall',
          description: 'Come help get the word out about our great campaign.'
        }
      end

      context 'when making a request' do
        before do
          stub_request(:put, url)
        end

        it 'makes a put request' do
          NgpVan.put(path: '/some/resource')
          expect(a_request(:put, url)).to have_been_made
        end
      end

      context 'when passing a body to the request' do
        before do
          stub_request(:put, url).with(body: JSON.generate(body))
        end

        it 'passes body to the request' do
          NgpVan.put(path: '/some/resource', body: body)

          expect(a_request(:put, url).with(body: JSON.generate(body)))
            .to have_been_made
        end
      end
    end
  end
end
