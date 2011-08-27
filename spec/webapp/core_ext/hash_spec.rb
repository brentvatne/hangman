require 'rspec'
require File.expand_path("../../../../webapp/core_ext/hash", __FILE__) 

describe Hash do

  before(:each) do
      @html_filled_hash = { 
        :first_key  => "<img src=\"img.jpg\">some image",
        :second_key => "<p><i><b>bobby</b></i></p>" 
      }
      @same_hash_without_html = { 
        :first_key  => "some image",
        :second_key => "bobby", 
      }
  end

  describe "#sanitize_html" do
    it "should return a copy of the hash with HTML tags removed from each value" do
      @html_filled_hash.sanitize_html.should == @same_hash_without_html
      @html_filled_hash.should_not == @same_hash_without_html
    end
  end

  describe "#sanitize!" do
    it "should mutate the original object" do   
      @html_filled_hash.sanitize_html!
      @html_filled_hash.should == @same_hash_without_html 
    end
  end
end
