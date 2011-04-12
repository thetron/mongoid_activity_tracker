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
      def current_user
        "Unknown user"
      end

      def resource_url
        nil
      end

      def activity_scopes
        []
      end

      def resource
        "Unknown document"
      end

      def resource_name
        resource.class.to_s.humanize
      end

      def resource_description
        resource.to_s
      end

      def track_activity
        MongoidActivityTracker::UserActivity.create!(
          :author => current_user,
          :description => resource_description,
          :action => self.action_name,
          :resource_name => resource_name,
          :tags => activity_scopes.join(','),
          :resource_url => resource_url
        )
      end
    end
  end
end
