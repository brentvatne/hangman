require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib hangman]))

def solve_puzzle(hangman)
  hangman.guess(hangman.solution_diff.keys.reverse.join)
end

def setup_empty_test_datamapper_db
  require 'sqlite3'
  DataMapper.setup :default, 'sqlite3::memory:'
  DataMapper.auto_migrate!
end
