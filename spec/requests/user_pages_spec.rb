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
     # let(:user) { FactoryGirl.create(:user) }
     # before { valid_signin(user) }
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
        it { should have_link('Sign out') }
      end

    end #with valid information
  end #signup
  describe "edit page" do
    let(:user) {FactoryGirl.create(:user)}
    before  do 
    sign_in user
    visit edit_user_path(user)
    end

    describe "subject" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") } 
      it { should have_link('change', href:'http://gravatar.com/emails') } 
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') } 
    end
        
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before(:each) do
      	fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end
      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should == new_name } 
      specify { user.reload.email.should == new_email }
    end# with valid information
  end#edit

  describe "index" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name:"Bob",email:"bob@example.com")
      FactoryGirl.create(:user, name:"Ben",email:"ben@example.com")
      visit users_path
    end
    it { should have_selector('title', text:"All users") } 
    it { should have_selector('h1',text:"All users") }
     describe "pagination" do
       before(:all) {30.times {FactoryGirl.create(:user)} }
       after(:all) {User.delete_all}
	it { should have_selector('div.pagination') } 
       it "should list each user" do
         User.paginate(page: 1).each do |user|
          page.should have_selector('li',text:user.name)#当前这一面应该有该user
         end 
       end#should list each user
     end#pagination
     describe "delete links" do
      #admin可以看到delete链接
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) } #创建一个admin的FG用户 并访问user的index
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          #delete一个user 会造成user信息少一个
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        # 无法删除自己
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end#delete links
  end#index

  #--/show micropost
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end

end #User pages
