require 'pathname'
require 'rake'
require 'rspec/core/rake_task'

#Make sure the project directory is in the load path
current_path = File.dirname(Pathname.new(File.expand_path(__FILE__)).realpath.to_s).to_s
$LOAD_PATH.unshift current_path unless $LOAD_PATH.include?(current_path)

RSpec::Core::RakeTask.new('unit') do |t|
  t.pattern = FileList['spec/**/*_spec.rb'].exclude("integration")
end

RSpec::Core::RakeTask.new('int') do |t|
  t.pattern = FileList['spec/webapp/integration/*_spec.rb']
end

RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :unit

