module TrackerApi
  module Endpoints
    class StoryTransitions
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, params={})
        data = client.get("/projects/#{project_id}/story_transitions", params: params).body

        puts data.first

        data.map do |transition|
          Resources::StoryTransition.new({ client: client, project_id: project_id }.merge(transition))
        end
      end

    end
  end
end
