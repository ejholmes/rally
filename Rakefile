#!/usr/bin/env rake
require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'

  desc 'Run specs'
  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end

  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end

  task :default do
    Rake::Task['spec'].invoke
    Rake::Task['features'].invoke
  end
rescue LoadError
  # No specs in production.
end
