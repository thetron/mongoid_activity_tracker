require 'mongoid_taggable'

module MongoidActivityTracker
  class UserActivity
    include Mongoid::Document
    include Mongoid::Timestamps

    field :author
    field :description
    field :action
    field :resource_name

    field :resource_url
  end
end
