require 'spec_helper'

describe "StaticPages" do

let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
    before {visit root_path}
    it "should have the h1 'Phoenix OA' Method1" do
      #add before{} visit root_path#'/static_pages/home'
      page.should have_content('Phoenix OA')
    end

    it "should have the h1 'Phoenix OA' Method2" do
      #visit root_path#'/static_pages/home'
      page.should have_selector('h1', :text=>'Phoenix OA')
    end

    it "should have the title 'Home'" do
      #visit root_path#'/static_pages/home'
      page.should have_selector('title', :text=>full_title(''))
    end

    it "should not have a custom page title" do
      #visit root_path#'/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
  end
#-- Help Page
  describe "Help page" do
    it "should have the h1 'help' " do
      #visit '/static_pages/help'
      visit help_path
      page.should have_content('Help')
    end 

    it "should have the title 'Help'" do
      #visit '/static_pages/help'
      visit help_path
      page.should have_selector('title', :text=>"#{base_title}")
    end

    it "help should not have a custom page title" do
      #visit '/static_pages/help'
      visit help_path
      page.should_not have_selector('title', :text => '| Help')
    end

  end
#-- About us
  describe "About Us" do
    before {visit about_path}
    it "should have the h1 'About Us' " do
      #visit about_path
      page.should have_content('About Us')
    end
    it "should have the title 'About Us'" do
      #visit about_path
      #page.should have_selector('title',:text => "Ruby on Rails Tutorial Sample App | About Us")
      page.should have_selector('title',:text => full_title('About Us'))
    end

  end
#-- contact
  describe "Contact" do
    before {visit contact_path}
    it "should have the h1 'Contact' " do
      #visit contact_path
      page.should have_content('Contact')
    end

    it "should have the H1 contenct 'Contact' Method2" do
      page.should have_selector('title',:text=>'Contact')
    end
   
    it "should have the title 'Contact'" do
      #visit contact_path
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end

  end

end
