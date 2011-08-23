require 'data_mapper'

DB_PATH = File.expand_path("../db/hangman_puzzles.sqlite3", __FILE__) 

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite://#{DB_PATH}")
DataMapper.finalize
DataMapper.auto_upgrade!
