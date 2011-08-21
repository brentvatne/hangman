spec_defaults = lambda do |spec|
  spec.pattern    = 'spec/**/*_spec.rb'
  spec.rspec_opts = '--options ' << 'spec/spec.opts'
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec, &spec_defaults)
rescue LoadError
  task :spec do
    abort 'rspec is not available. In order to run spec, you must: gem install rspec'
  end
end

task :default => :spec
