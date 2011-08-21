require 'rubygems'
require 'rake'
require 'pathname'

#Make sure the project directory is in the load path
current_path = File.dirname(Pathname.new(File.expand_path(__FILE__)).realpath.to_s).to_s
$LOAD_PATH << current_path unless $LOAD_PATH.include?(current_path)

begin
  FileList['tasks/*.rake'].each { |task| import task }

rescue LoadError => e
  puts e.backtrace #Shows which dependency is missing 
end

