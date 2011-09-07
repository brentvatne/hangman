class Hangman
  class InvalidGuessError < StandardError; end
  class BadInputDataError < StandardError; end

  attr_accessor :solution_diff, :puzzle_with_guesses, 
                :guesses_remaining 

  #having this and load separate is not a good idea
  #it makes more sense to have whatever external class handle the loading
  def initialize(puzzle_data, guesses=7)
    unless puzzle_data.nil?
      @puzzle_data   = puzzle_data
      if @puzzle_data.respond_to?(:puzzle_with_markup)
        pwm = @puzzle_data.puzzle_with_markup
      else
        pwm = @puzzle_data
      end
      parser = HangmanParser.new(pwm)
      parser.parse
      @puzzle        = parser.puzzle
      @solution      = parser.solution
      @solution_diff = parser.solution_diff 
      @total_guesses = guesses
      prepare_for_new_game
    end
  end
  
  class << self
    def load_if_filename(puzzle_or_filename)
      puzzle_or_filename = File.read(puzzle_or_filename) if File.exists?(puzzle_or_filename)
      puzzle_or_filename
    end

    def load(puzzle, guesses=7) 
      puzzle = load_if_filename(puzzle)
      new(puzzle, guesses)
    end
  end

  def method_missing(m)
   @puzzle_data.send(m) 
  end

  def guesses
    @symbols_guessed.values.flatten.uniq.join(", ")
  end

  def prepare_for_new_game
    @puzzle_with_guesses = @puzzle.dup
    @guesses_remaining   = @total_guesses
    @symbols_guessed     = { :correct => [], :incorrect => [] }
    @solved              = false
    self
  end

  def number_of_guesses
    @symbols_guessed.values.flatten.count
  end

  def number_of_incorrect_guesses
    incorrect_guesses.count
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
      @symbols_guessed[:correct].push symbol 
      fill_in_puzzle_with symbol
    else
      @symbols_guessed[:incorrect].push symbol
      @guesses_remaining -= 1
    end

    number_of_occurences_in_solution(symbol)
  end

  def game_over?
    (@guesses_remaining == 0) or solved?
  end

  def solved?
    @symbols_guessed[:correct].sort == @solution_diff.keys.sort
  end

  def solution_contains?(symbol)
    @solution_diff.include?(symbol)
  end

  def incorrect_guesses
    @symbols_guessed[:incorrect]
  end

  def correct_guesses
    @symbols_guessed[:correct]
  end

  def already_guessed?(symbol)
    @symbols_guessed.values.flatten.include?(symbol)
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
