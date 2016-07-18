module TrackerApi
  module Endpoints
    class StoryTransitions
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, id, params={})
        data = client.get("/projects/#{project_id}/story_transitions/#{id}", params: params).body

        Resources::StoryTransition.new({ client: client, project_id: project_id }.merge(data))
      end

    end
  end
end
