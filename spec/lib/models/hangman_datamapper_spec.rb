require 'rspec'
require 'hangman/models/hangman_puzzle'

describe HangmanPuzzle do
  setup_empty_test_datamapper_db

  describe "validations" do
    it "requires a name" do
      HangmanPuzzle.create(:name => nil).should_not be_valid
      HangmanPuzzle.create(:name => "Some puzzle name").should be_valid
    end
  end
end
