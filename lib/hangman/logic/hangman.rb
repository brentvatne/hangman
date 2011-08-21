require 'data_mapper'
require 'hangman/parser/hangman_parser'

class Hangman
  class InvalidGuessError < StandardError; end
  class BadInputDataError < StandardError; end

  attr_accessor :solution_diff, :puzzle_with_guesses, 
                :guesses_remaining, :guessed 
  #TODO: rename guessed to already_guessed or something more helpful

  def initialize(puzzle_data, guesses=10)
    unless puzzle_data.nil?
      parser = HangmanParser.new(puzzle_data); parser.parse
      @puzzle        = parser.puzzle
      @solution      = parser.solution
      @solution_diff = parser.solution_diff 
      @total_guesses = 10
      prepare_for_new_game
    end
  end

  def prepare_for_new_game
    @puzzle_with_guesses = @puzzle.dup
    @guesses_remaining   = @total_guesses
    @guessed             = { :correct => [], :incorrect => [] }
    @solved              = false
  end
  
  class << self
    def load_if_filename(puzzle_or_filename)
      puzzle_or_filename = File.open(puzzle_or_filename).read if File.exists?(puzzle_or_filename)
      puzzle_or_filename
    end

    def load(puzzle, guesses = 10) 
      puzzle = load_if_filename(puzzle)
      new(puzzle, guesses)
    end
  end

  def number_of_guesses
    @guessed.values.flatten.count
  end

  def guess(symbol)
    if symbol.length > 1
      remaining_symbols = symbol[0..symbol.length-2]
      symbol            = symbol[symbol.length-1]  
      guess(remaining_symbols)
    end

    return if game_over?

    ensure_valid_guess!(symbol)

    if solution_contains?(symbol) and not already_guessed?(symbol) 
      @guessed[:correct].push symbol 
      fill_in_puzzle_with symbol
    else
      @guessed[:incorrect].push symbol
      @guesses_remaining -= 1
    end

    number_of_occurences_in_solution(symbol)
  end

  def game_over?
    (@guesses_remaining == 0) or solved?
  end

  def solved?
    #this is inefficient but the arrays will both always be very small
    @guessed[:correct].sort == @solution_diff.keys.sort
  end

  def solution_contains?(symbol)
    @solution_diff.include?(symbol)
  end

  def already_guessed?(symbol)
    @guessed.values.flatten.include?(symbol)
  end

  #Currently there are no invalid guesses
  def valid_symbol?(symbol)
    return false if [].include?(symbol)
    true
  end

  def ensure_valid_guess!(symbol)
    raise InvalidGuessError, "Invalid guess character" if not valid_symbol?(symbol)
  end

  def number_of_occurences_in_solution(symbol)
    if @solution_diff.include?(symbol)
      @solution_diff[symbol].count
    else
      0
    end
  end

  def fill_in_puzzle_with(symbol)
    @solution_diff[symbol].each do |index|
      @puzzle_with_guesses[index] = symbol
    end
  end

end
