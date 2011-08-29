require File.join(File.expand_path(File.dirname(__FILE__)), "integration_helper")

describe "creating a new puzzle", :type => :request do

  it "loads the new puzzle page given the correct path" do
    visit '/puzzles/new' 
    page.should have_content("Create new puzzle")
  end

  it "should escape html in the successfully created notification" do
    xss_attempt = "<script src=\"hack.js\"></script>"
    xss_neutralized = "&lt;script src=\"hack.js\"&gt;&lt;/script&gt;"
    visit '/puzzles/new'
    fill_in 'name',               :with => xss_attempt 
    fill_in 'problem_desc',       :with => "some problem"
    fill_in 'puzzle_with_markup', :with => "5 > 6"
    fill_in 'passing_tests',      :with => "not necessary"
    fill_in 'solution_desc',      :with => "about the puzzle"
    click_button 'Submit'

    page.html.should =~ /#{xss_neutralized} has been created/
  end

end
