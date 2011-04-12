require 'mongoid_taggable'

module MongoidActivityTracker
  module Helpers
    autoload :ActivityHelper, 'mongoid_activity_tracker/helpers/activity_helper'
  end
  autoload :Controller, 'mongoid_activity_tracker/controller'
end

require File.join(File.dirname(__FILE__), 'mongoid_activity_tracker/engine')
