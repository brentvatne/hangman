require 'data_mapper'

class HangmanPuzzle
  include DataMapper::Resource

  property :id,                 Serial
  property :name,               String, :required => true
  property :puzzle_with_markup, Text,   :required => true 
  property :problem_desc,       Text,   :required => true
  property :solution_desc,      Text,   :required => true
  property :passing_tests,      Text
  property :times_played,       Integer, :default => 0
  property :times_solved,       Integer, :default => 0
  property :created_on,         Date
  
  before :create, :sanitize_attributes

  def sanitize_attributes
  end
  
  def formatted_created_on
    created_on.strftime "%B %e"
  end

  def percent_solved
    times_played > 0 ? (times_solved / times_played)*100 : 0
  end

  class << self
    def recent
      last(5)
    end 
  end
end
