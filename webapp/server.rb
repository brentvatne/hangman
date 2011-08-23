require 'sinatra/base'
require 'haml'
require 'sass'
require 'rack-flash'
require File.expand_path("../../lib/hangman", __FILE__)
require File.expand_path(File.join(File.dirname(__FILE__), "dmconfig"))

class HangmanServer < Sinatra::Base
  use Rack::Flash

  set :haml, :format => :html5
  set :root, File.dirname(__FILE__)
  enable :sessions

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
      flash[:success] = "#{params[:name]} has been created!"
      redirect '/'
    else 
      flash[:error] = "Required fields are missing, please fill them in and try again."
      #show field errors somehow?
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

  run!
end

