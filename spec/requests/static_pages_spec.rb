require 'spec_helper'

describe "StaticPages" do

let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
    it "should have the h1 'Sample App' Method1" do
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end

    it "should have the h1 'Sample App' Method2" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text=>'Sample App')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text=>"Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
  end
#-- Help Page
  describe "Help page" do
    it "should have the h1 'help' " do
      visit '/static_pages/help'
      page.should have_content('Help')
    end 

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text=>"#{base_title}")
    end

    it "help should not have a custom page title" do
      visit '/static_pages/help'
      page.should_not have_selector('title', :text => '| Help')
    end

  end

  describe "About Us" do

    it "should have the h1 'About Us' " do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App | About Us")
    end

  end

  describe "Contact" do

    it "should have the h1 'Contact' " do
      visit '/static_pages/contact'
      page.should have_content('Contact')
    end
   
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end
  end

end