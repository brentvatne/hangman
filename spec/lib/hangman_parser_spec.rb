require 'rspec'
require 'spec_helper'

describe HangmanParser do

  before(:each) do
    @parser = HangmanParser.new(File.read(File.join(File.dirname(__FILE__),"sample_puzzle.txt")))
  end 

  describe "#parse" do
    it "must remove all hangman comment lines from parsed string" do
      @parser.parse
      @parser.puzzle.should_not =~ /^(\n)?#[\s^*]+HANGMAN(\r)?$/
    end
  end
end
