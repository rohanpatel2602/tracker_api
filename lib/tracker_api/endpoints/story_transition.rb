module TrackerApi
  module Endpoints
    class StoryTransitions
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, params={})
        transitions = []
        paginate = true

        while paginate
          response = client.get("/projects/#{project_id}/story_transitions", params: params)

          data = response.body
          data.each do |transition|
            transitions.push(Resources::StoryTransition.new({ client: client, project_id: project_id }.merge(transition)))
          end

          total = response.headers["X-Tracker-Pagination-Total"].to_i
          offset = response.headers["X-Tracker-Pagination-Offset"].to_i
          returned = response.headers["X-Tracker-Pagination-Returned"].to_i
          if total > (offset + returned)
            paginate = true
            params[:offset] = offset + returned
          else
            paginate = false
          end
        end

        transitions
      end

    end
  end
end
