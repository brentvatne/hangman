require File.join(File.expand_path(File.dirname(__FILE__)), "integration_helper")

describe "creating a new puzzle", :type => :request do

  it "loads the new puzzle page given the correct path" do
    visit '/puzzles/new' 
    page.should have_content("Create new puzzle")
  end

  # todo: this is testing that the page it redirects to has this content,
  # an indirect way of testing that the attribute is saved with escaped html 
  it "prevents xss by escaping html tags in puzzle attributes" do
    xss_attempt = "<script src=\"hack.js\"></script>"
    xss_neutralized = "&lt;script src=\"hack.js\"&gt;&lt;/script&gt;"

    visit '/puzzles/new'
    fill_in 'name',               :with => xss_attempt 
    fill_in 'problem_desc',       :with => "some problem"
    fill_in 'puzzle_with_markup', :with => "5 > 6"
    fill_in 'passing_tests',      :with => "not necessary"
    fill_in 'solution_desc',      :with => "about the puzzle"
    click_button 'Submit'

    HangmanPuzzle.last[:name].should == xss_neutralized
  end

end
