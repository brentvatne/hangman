require File.expand_path(File.join(File.dirname(__FILE__),'../lib/hangman'))

class HangmanCommandline
  
  class << self

    def load(puzzle_or_filename)
      @hangman = Hangman.load(puzzle_or_filename)
      game_loop
    end

    def restart
      @hangman.prepare_for_new_game
      game_loop
    end

    def clear_console
      puts `clear`
    end

    def display_puzzle
      puts @hangman.puzzle_with_guesses
    end

    def display_remaining_guesses
      puts "\nYou have #{@hangman.guesses_remaining} guesses remaining."
    end

    def continue?
      puts "Try again? y/n"
      continue = gets.chomp.downcase
      continue = continue[0] if continue.length > 1;
      continue == "y"
    end

    def game_loop
      until @hangman.game_over? 
        clear_console
        display_puzzle
        display_remaining_guesses

        guess = gets.chomp
        @hangman.guess(guess)
      end

      if @hangman.solved?
        clear_console
        display_puzzle
        puts "\n# Congrats! It only took you #{@hangman.number_of_guesses} guesses!" 
      else
        puts "# FirstWorldProblems: you just lost at Ruby hangman."
        restart if continue?
      end 
    end

  end

end

#To run it:
HangmanCommandline.load('/Users/brentvatne/ruby_projects/hangman/commandline/sample_puzzle.txt')
