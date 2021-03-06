module MongoidActivityTracker
  module Helpers
    module ActivityHelper
      def user_activity_feed(user, options = {})
        options[:user] = user
        activity_feed(options)
      end

      # Available options:
      # limit - number of results to return
      # user_id - limit to user id scope
      # scope - array of scopes to filter by
      def activity_feed(options = {})
        options[:limit] ||= 50
        criteria = MongoidActivityTracker::Event.desc :created_at
        if options[:scopes]
          criteria.any_in :tags_array => options[:scopes]
        end
        criteria.limit(options[:limit])
      end
    end
  end
end
