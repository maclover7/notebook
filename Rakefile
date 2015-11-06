require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'

# RSpec Rake Task
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# Rubocop Rake Task
require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: [:rubocop, :spec]
