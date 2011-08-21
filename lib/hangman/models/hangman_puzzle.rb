require 'data_mapper'

class HangmanPuzzle
  include DataMapper::Resource

  property :id,                 Serial
  property :name,               String, :required => true
  property :puzzle_with_markup, Text, :required => true 
  property :problem_desc,       Text, :required => true
  property :solution_desc,      Text, :required => true
  property :passing_tests,      Text
  #property :times_played,  Integer
  #property :times_solved,  Integer
end


