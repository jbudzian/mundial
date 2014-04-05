require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Mundial Tournament'" do
      visit '/static_pages/home'
      page.should have_content('Mundial Tournament')
    end
  end

  describe "Rules page" do
    it "should have the content 'rules'" do
      visit '/static_pages/rules'
      page.should have_content('rules')
    end
  end
end
