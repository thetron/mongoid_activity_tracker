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

      def resource_url(model)
        nil
      end

      def activity_scopes(model)
        []
      end

      def resource
        "Unknown document"
      end

      private
      def track_activity
        MongoidActivityTracker::UserActivity.create!(
          :author => current_user,
          :description => resource.to_s,
          :action => self.action_name,
          :model_name => resource.class.to_s.humanize,
          :tags => activity_scopes(resource).join(','),
          :resource_url => resource_url(resource)
        )
      end
    end
  end
end
