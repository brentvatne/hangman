require 'capybara/rspec'
require File.expand_path("../../../../webapp/server.rb", __FILE__) 

Capybara.app = HangmanServer
