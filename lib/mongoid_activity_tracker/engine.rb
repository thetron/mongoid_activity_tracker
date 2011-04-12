module MongoidActivityTracker
  class Engine < Rails::Engine
    #ActionController::Base.helper(MongoidActivityTracker::Helpers::ActivityHelper)
  end
end

module ActionController
  class Base
    include MongoidActivityTracker::Controller
  end
end
