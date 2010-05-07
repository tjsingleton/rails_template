require 'hydra'
require 'hydra/tasks'

# set up a new hydra testing task named 'hydra:spec' run with "rake hydra:spec"
Hydra::TestTask.new('hydra:spec' => ["environment"]) do |t|
  # add all files in the spec directory that end with "_spec.rb"
  require "spec/spec_helper"
  t.add_files 'spec/**/*_spec.rb'
end

# set up a new hydra testing task named 'hydra:cucumber' run with "rake hydra:cucumber"
Hydra::TestTask.new('hydra:cucumber') do |t|
  # add all files in the features directory that end with ".feature"
  t.add_files 'features/**/*.feature'
end

task :hydra => ['hydra:spec', 'hydra:cucumber']
