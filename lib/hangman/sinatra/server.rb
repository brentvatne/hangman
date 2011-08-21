require 'sinatra'
require 'haml'
require 'sass'
require 'data_mapper'

set :haml, :format => :html5

get '/css/style.css' do
  scss :style 
end

get '/' do
  @title = "Ruby Hangman!"
  @msg = "Test message!"
  haml :index
end

get '/puzzles/new' do
  @hide_upload_puzzle = true
  haml "/puzzles/new".to_sym 
end

post '/puzzles/create' do
  "get posted data and create new database entry, then redirect to main page with a note that it has been made"
end

get '/puzzles/:id' do
  "the easiest way to do it, assuming each one has an id of some sort"
end
#get '/:puzzle_name' do
#  "here is where you do the puzzles! the fun begins"
#end

