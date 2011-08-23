require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/lib/hangman/sinatra/db/hangman_puzzles.sqlite3")
DataMapper.finalize
DataMapper.auto_upgrade!
