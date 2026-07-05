# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe ChangedEntityExportJobs do
      let(:client) { NgpVan::Client.new }

      describe '#changed_entity_resources' do
        let(:response) { fixture('changed_entity_resources.json') }
        let(:url) { build_url(client: client, path: 'changedEntityExportJobs/resources') }

        before do
          stub_request(:get, url).to_return(body: response)
        end

        it 'requests the correct resource' do
          client.changed_entity_resources
          expect(a_request(:get, url)).to have_been_made
        end

        it 'returns an array of resource types' do
          resources = client.changed_entity_resources
          expect(resources).to be_a(Array)
        end
      end

      describe '#changed_entity_fields' do
        let(:response) { fixture('changed_entity_fields.json') }
        let(:url) do
          build_url(client: client, path: 'changedEntityExportJobs/fields/Contributions')
        end

        before do
          stub_request(:get, url).to_return(body: response)
        end

        it 'requests the correct resource' do
          client.changed_entity_fields(resource_type: 'Contributions')
          expect(a_request(:get, url)).to have_been_made
        end

        it 'returns an array of field definitions' do
          fields = client.changed_entity_fields(resource_type: 'Contributions')
          expect(fields).to be_a(Array)
        end
      end

      describe '#create_changed_entity_export_job' do
        let(:body) do
          JSON.parse(File.read("#{fixture_path}/create_changed_entity_export_job.json"))
        end

        let(:response) { fixture('changed_entity_export_job.json') }
        let(:url) { build_url(client: client, path: 'changedEntityExportJobs') }

        before do
          stub_request(:post, url)
            .with(body: JSON.generate(body))
            .to_return(
              status: 201,
              body: response
            )
        end

        it 'requests the correct resource' do
          client.create_changed_entity_export_job(body: body)
          expect(
            a_request(:post, url).with(body: body)
          ).to have_been_made
        end

        it 'returns the export job' do
          job = client.create_changed_entity_export_job(body: body)
          expect(job['exportJobId']).to eq(555444333)
        end
      end

      describe '#changed_entity_export_job' do
        let(:response) { fixture('changed_entity_export_job.json') }
        let(:url) { build_url(client: client, path: 'changedEntityExportJobs/555444333') }

        before do
          stub_request(:get, url).to_return(body: response)
        end

        it 'requests the correct resource' do
          client.changed_entity_export_job(id: 555444333)
          expect(a_request(:get, url)).to have_been_made
        end

        it 'returns the requested export job' do
          job = client.changed_entity_export_job(id: 555444333)
          expect(job['exportJobId']).to eq(555444333)
        end
      end
    end
  end
end
