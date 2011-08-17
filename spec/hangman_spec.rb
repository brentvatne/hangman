require 'rubygems'
require 'rspec'
require './hangman.rb'

describe Hangman do
  ValidPuzzle = File.open("spec/sample_puzzle.txt").read

  describe "#initialize" do
    #what can I test on this?
    #could test that it initializes everything but that seems pointless?
  end

  describe "#guess" do
    before(:each) do
      @hangman = Hangman.load(ValidPuzzle)
    end

    it "should return the number of occurrences when the symbol is in the puzzle" do
      @hangman.guess("a").should == 2
      @hangman.guess("r").should == 2
      @hangman.guess("i").should == 1
    end

    it "should return 0 when the symbol is valid but is not in the puzzle" do
      @hangman.guess("z").should == 0
    end 

    it "should raise an InvalidGuessError if it is not an acceptable guess string" do
      invalid_characters = %w() 
      invalid_characters.each do |invalid_character|
        lambda { @hangman.guess(invalid_character) }.should raise_error(InvalidGuessError) 
      end
    end

    it "should have one less guess remaining if the guess is incorrect" do
      #Brent: What's the reasoning behind including abs? Doesn't seem to work when I do it - Rspec says it was not changed
      expect { @hangman.guess("z") }.to change{@hangman.guesses_remaining}.by(-1)
    end 

    it "should not affect the number of guesses if the guess is correct" do
      expect { @hangman.guess("a") }.not_to change{@hangman.guesses_remaining}
    end

    it "should add (in)correctly guessed symbols to guessed[:(in)correct]" do
      guesses = %w[a b z x]
      guesses.each { |e| @hangman.guess(e) }

      @hangman.guessed[:correct].should == %w(a b)
      @hangman.guessed[:incorrect].should == %w(z x)
    end
  end
end

