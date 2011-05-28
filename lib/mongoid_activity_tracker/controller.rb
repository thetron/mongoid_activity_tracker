module MongoidActivityTracker
  module Controller
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      def tracks_activity(*args)
        options = args.extract_options!
        options[:actions] ||= [:create, :update, :destroy]
        options[:actions] = Array(options[:actions]) # ensures array was passed in, if only one action required
        self.after_filter :track_activity, :only => options[:actions]
      end
    end

    module InstanceMethods
      include ActiveSupport::Inflector

      protected
      def skip_tracking
        @skip_mongoid_activity_tracker = true
      end

      def current_user
        "Unknown user"
      end

      def activity_scopes
        []
      end

      def resource
        "Unknown document"
      end

      def resource_name
        "the #{resource.class.to_s.humanize}"
      end

      def resource_description
        resource.to_s
      end

      def past_tense_action_name_for(action)
        if action[-1..-1] == "e"
          action + "d"
        else
          action + "ed"
        end
      end

      def track_activity
        unless @skip_mongoid_activity_tracker
          MongoidActivityTracker::Event.create!(
            :author => current_user,
            :description => resource_description,
            :action => past_tense_action_name_for(self.action_name),
            :resource_name => resource_name,
            :tags => activity_scopes.join(','),
            :resource_url => self.respond_to?(:resource_url) ? self.send(:resource_url) : nil
          )
        end
      end
    end
  end
end
