require 'rspec'
require 'hangman/models/hangman_puzzle'

describe HangmanPuzzle do
  setup_empty_test_datamapper_db
  
  before(:each) do
    @valid_attrs = {
      :name => "A valid name",
      :puzzle_with_markup => "Any string will do",
      :problem_desc => "Also any string is okay",
      :solution_desc => "There is certainly a trend here; any string works",
      :passing_tests => "Not going to repeat myself again"
    }
  end

  describe "validations" do
    it "should be valid if it is created with valid attributes" do
      HangmanPuzzle.create(@valid_attrs).should be_valid
    end

    it "requires a name" do
      HangmanPuzzle.create(@valid_attrs.merge(:name => nil)).should_not be_valid
    end

    # TODO: should there be a minimum length? Should definitely be a maximum length
    it "requires a puzzle with markup" do
      HangmanPuzzle.create(@valid_attrs.merge(:puzzle_with_markup => nil)).should_not be_valid
    end
    it "requires a problem description" do
      HangmanPuzzle.create(@valid_attrs.merge(:problem_desc => nil)).should_not be_valid
    end

    it "requires a solution description" do
      HangmanPuzzle.create(@valid_attrs.merge(:solution_desc => nil)).should_not be_valid
    end
  end
end
