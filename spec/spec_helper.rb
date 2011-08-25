#make individual spec_helper in each directory which requires this spec helper
require File.expand_path("../../lib/hangman", __FILE__) 

def solve_puzzle(hangman)
  hangman.guess(hangman.solution_diff.keys.reverse.join)
end

def setup_empty_test_datamapper_db
  require 'sqlite3'
  DataMapper.setup :default, 'sqlite3::memory:'
  DataMapper.auto_migrate!
end
