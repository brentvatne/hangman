require 'sinatra/base'
require 'haml'
require 'sass'
require 'rack-flash'
require File.expand_path("../core_ext/hash", __FILE__)
require File.expand_path("../../lib/hangman", __FILE__)
require File.expand_path("dmconfig", File.dirname(__FILE__))
require File.expand_path("hangman_ascii", File.dirname(__FILE__))
require File.expand_path("html_printer", File.dirname(__FILE__))

class HangmanServer < Sinatra::Base
  use Rack::Flash

  set :root, File.dirname(__FILE__)
  set :haml, :format => :html5
  enable :sessions

  get '/' do
    @title   = "Ruby Hangman!"
    @recent_puzzles = HangmanPuzzle.recent
    haml "/puzzles/index".to_sym
  end

  get '/puzzles/new' do
    @hide_upload_puzzle = true
    haml "/puzzles/new".to_sym
  end

  post '/puzzles/create' do
    safe_params = params.escape_html
    new_puzzle = HangmanPuzzle.create(safe_params)
    if new_puzzle.saved?
      flash[:success] = "#{new_puzzle[:name]} has been created!"
      redirect '/'
    else
      flash[:error] = "Required fields are missing, please fill them in and try again."
      redirect '/puzzles/new'
    end
  end

  get %r{/puzzles/([\d]+)/(.+)} do
    id = params[:captures][0]
    guesses = params[:captures][1]
    @puzzle = Hangman.new(HangmanPuzzle.get!(id))
    @puzzle.guess(guesses) 
    @drawing = HangmanAscii.draw(@puzzle.number_of_incorrect_guesses)
    haml "/puzzles/play".to_sym
  end

  get %r{/puzzles/([\d]+)} do
    id = params[:captures].first
    @puzzle = Hangman.new(HangmanPuzzle.get!(id))
    @drawing = HangmanAscii.draw(0)
    haml "/puzzles/play".to_sym
  end

  #get '/:puzzle_name' do
  # can't contain / or .?
  #end

  get '/css/style.css' do
    scss :style
  end

end
