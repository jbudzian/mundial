require 'spec_helper'

describe "Static pages" do
  describe "Rules page" do
    it "should have the content 'rules'" do
      visit '/static_pages/rules'
      page.should have_content('rules')
    end
  end
end
