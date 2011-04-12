# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid_activity_tracker/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_activity_tracker"
  s.version     = MongoidActivityTracker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Bruning"]
  s.email       = ["nicholas@bruning.com.au"]
  s.homepage    = ""
  s.summary     = %q{Provides basic user activity tracking.}
  s.description = %q{Mongoid Activity Tracker makes it easy to track a user's activity, easily retrievable in a fully-scopeable activity feed.}

  s.rubyforge_project = "mongoid_activity_tracker"

  s.add_dependency 'mongoid', '>=2.0.0'
  s.add_dependency 'mongoid_taggable', '0.1.4'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
