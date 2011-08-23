require 'sinatra'
require 'haml'
require 'sass'
require 'dmconfig' #how do I not load this when I'm testing?

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
  new_puzzle = HangmanPuzzle.create(params)
  if new_puzzle.saved? 
    @flash[:success] = "#{params[:name]} has been created!"
    #how do I re-create flash?
    redirect '/'
  else 
    #flash[:error] = "..."
    #show field errors
    redirect '/puzzles/new'
  end
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

