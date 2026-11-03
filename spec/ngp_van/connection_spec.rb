# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  RSpec.describe Connection do
    let(:client) { NgpVan::Client.new }
    let(:url) { build_url(client: client, path: '/some/resource') }
    let(:middleware) do
      Class.new(Faraday::Middleware) do
        def on_request(env)
          env.request_headers['X-Test-Middleware'] = 'yes'
        end
      end
    end

    before do
      NgpVan.configuration.reset!
      stub_request(:get, url).to_return(status: 429, body: '')
    end

    after { NgpVan.configuration.reset! }

    it 'has no extra middleware by default' do
      expect(NgpVan.configuration.faraday_middleware).to be_nil
      expect { NgpVan.get(path: '/some/resource') }.to raise_error(NgpVan::TooManyRequests)
    end

    it 'adds the configured middleware to every request, outside the error handling' do
      NgpVan.configure do |config|
        config.faraday_middleware = ->(connection) { connection.use middleware }
      end

      expect { NgpVan.get(path: '/some/resource') }.to raise_error(NgpVan::TooManyRequests)
      expect(a_request(:get, url).with(headers: { 'X-Test-Middleware' => 'yes' })).to have_been_made
    end
  end
end
