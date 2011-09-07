class HangmanAscii
  Picture = <<-END_HANGMAN
      0000000000000
      0           0
      0           1
      0          1 1
      0           1
      0          324
      0         3 2 4
      0        3  2  4
      0          5 6
      0         5   6
      0        5     6
      0       5       6
      0
      0
      0
  END_HANGMAN

  class << self
    def draw(incorrect_guesses)
      incorrect_guesses = 7 if incorrect_guesses > 7 
      numbers_to_hide = (incorrect_guesses..7).to_a.join
      Picture.gsub(/[#{numbers_to_hide}]/,"")
    end
  end
end
