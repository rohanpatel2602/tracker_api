module TrackerApi
  module Resources
    class StoryTransition
      include Shared::Base

      attribute :client

      attribute :kind, String
      attribute :state, String # (accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled)
      attribute :story_id, Integer
      attribute :project_id, Integer
      attribute :project_version, Integer
      attribute :occurred_at, DateTime
      attribute :performed_by_id, Integer

      class UpdateRepresenter < Representable::Decorator
        include Representable::JSON

        property :state
        property :story_id
        property :project_id
        property :project_version
        property :occurred_at
        property :performed_by_id
      end

      # Provide the project of the story
      #
      # @param [Hash] params
      # @return [Project]
      def project(params = {})
        @project ||= Endpoints::Activity.new(client).get_story(project_id, id, params)
      end

      # Provides a list of all the comments on the story.
      #
      # @param [Hash] params
      # @return [Person]
      def performed_by(params = {})
        #TODO
      end

    end
  end
end
