require 'sinatra/base'
require 'haml'
require 'sass'
require 'rack-flash'
require File.expand_path("../../lib/hangman", __FILE__)
require File.expand_path("dmconfig", File.dirname(__FILE__))

class HangmanServer < Sinatra::Base
  use Rack::Flash

  set :root, File.dirname(__FILE__)
  set :haml, :format => :html5
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
    #no need to sanitize for SQLi as DataMapper takes care of it
    new_puzzle = HangmanPuzzle.create(params.sanitize_html)
    if new_puzzle.saved?
      flash[:success] = "#{params[:name]} has been created!"
      redirect '/'
    else
      flash[:error] = "Required fields are missing, please fill them in and try again."
      # todo: show errors on each field
      redirect '/puzzles/new'
    end
  end

  get %r{/puzzles/([\d]+)} do
    id = params[:captures].first
  end

  #get '/:puzzle_name' do
  #  "here is where you do the puzzles! the fun begins"
  #end

  get '/css/style.css' do
    scss :style
  end

  run!
end

