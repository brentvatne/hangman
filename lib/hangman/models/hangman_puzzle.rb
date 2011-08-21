require 'data_mapper'

class HangmanPuzzle
  include DataMapper::Resource

  property :id,             Serial
  property :name,           String, :required => true
  property :puzzle,         Text
  property :solution,       Text
  property :problem_desc,   Text
  property :solution_desc,  Text
  property :passing_tests,  Text
  #property :times_played,  Integer
  #property :times_solved,  Integer
end


