require 'sinatra'
require 'haml'
require 'sass'
require 'hangman/sinatra/dmconfig'

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

end

get '/puzzles/:id' do
  # TODO:
  # check to see that the param is a number
  # this implies that names cannot be just numbers (validation will be required)
end

#get '/:puzzle_name' do
#  "here is where you do the puzzles! the fun begins"
#end

