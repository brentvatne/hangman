$LOAD_PATH << Dir.pwd + "/lib"
require 'sinatra'
require 'haml'
require 'sass'
require 'hangman/sinatra/dmconfig' #how do I not load this when I'm testing?

set :haml, :format => :html5

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
  HangmanPuzzle.create({
    :name => params[:name],
    :problem_desc => params[:problem_desc],
    :puzzle_with_markup => params[:puzzle_with_markup],
    :passing_tests => params[:passing_tests],
    :solution_desc => params[:solution_desc]
  }) 
  # TODO: redirect to index with a flash notice 
end

get '/puzzles/:id' do
  # TODO:
  # check to see that the param is a number
  # this implies that names cannot be just numbers (validation will be required)
end

get '/css/style.css' do
  scss :style 
end

#get '/:puzzle_name' do
#  "here is where you do the puzzles! the fun begins"
#end

