require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "Profile page" do
    let(:demo_user) { FactoryGirl.create(:user) }
    before { visit user_path(demo_user) }
      it {should have_selector('h1', text: demo_user.name)}
      it {should have_selector('title', text: demo_user.name)}
  end
  #FactoryGirl 是模拟了一个user model的对象
  describe "Factory Girl" do
    before { @user_fg = FactoryGirl.create(:user) }
    before { visit user_path(@user_fg) }
      it {should have_selector('h1', text: @user_fg.name)}
  end

  describe "Factory Girl 2" do
    before { visit user_path(FactoryGirl.create(:user)) }
      it {should_not have_selector('h1',text:'Sign up')}
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    #把按钮let出来
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before { click_button submit } #什么都不写 直接提交
          it { should have_selector('title', :text=>full_title('Sign up')) }
	  it { should have_content('error') }
          it { should have_content('The form contains 7 errors.') } #返回的标准错误
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
	let(:user) { User.find_by_email('user@example.com') }
        #save以后 by email去数据库把user信息抓出来 和注册成功后的页面信息作对比
	it { should have_selector('title', text: user.name) }
	it { should have_selector('h1', text: user.name) }
	it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

    end #with valid information

  end #signup

end #User pages
