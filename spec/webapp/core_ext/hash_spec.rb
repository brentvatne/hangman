require 'rspec'
require File.expand_path("../../../../webapp/core_ext/hash", __FILE__) 

describe Hash do

  before(:each) do
      @html_filled_hash = { 
        :first_key  => "<img src=\"img.jpg\">some image",
        :second_key => "<p>bobby</p>" 
      }
      @same_hash_with_html_escaped = { 
        :first_key  => "&lt;img src=\"img.jpg\"&gt;some image",
        :second_key => "&lt;p&gt;bobby&lt;/p&gt;", 
      }
  end

  describe "#escape_html" do
    it "should return a copy of the hash with HTML tags removed from each value" do
      @html_filled_hash.escape_html.should == @same_hash_with_html_escaped
      @html_filled_hash.should_not == @same_hash_with_html_escaped
    end
  end

  describe "#escape!" do
    it "should mutate the original object" do   
      @html_filled_hash.escape_html!
      @html_filled_hash.should == @same_hash_with_html_escaped 
    end
  end
end
