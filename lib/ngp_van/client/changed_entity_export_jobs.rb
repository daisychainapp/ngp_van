# frozen_string_literal: true

module NgpVan
  class Client
    module ChangedEntityExportJobs
      def changed_entity_resources
        get(path: 'changedEntityExportJobs/resources')
      end

      def changed_entity_fields(resource_type:)
        verify_id(resource_type)
        get(path: "changedEntityExportJobs/fields/#{resource_type}")
      end

      def create_changed_entity_export_job(body: {})
        post(path: 'changedEntityExportJobs', body: body)
      end

      def changed_entity_export_job(id:)
        verify_id(id)
        get(path: "changedEntityExportJobs/#{id}")
      end
    end
  end
end
