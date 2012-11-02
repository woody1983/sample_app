require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }  # 先page这个对象 subject出来
  
  describe "sign in page" do
    before { visit signin_path } #测试之前 先访问这个登陆页面
    it { should have_selector('h1',text:'Sign in') } #应该可以看到这些字样
    it { should have_selector('title',text:'Sign in') }
  end #sign in page

  describe "signin"do
    before { visit signin_path } 
    describe "With Invalid Information"do #使用无效信息
      before { click_button "Sign in" } #测试之前先点击 sign in
      it { should have_selector('title',text:'Sign in') } #应该还是会出现提示sign的字样
      it { should have_selector('div.alert.alert-error', text: 'Invalid') } #显示无效invalid字样
      describe "after visiting another page" do #访问其他页面的时候
        before { click_link "Home" } #点击home
        it { should_not have_selector('div.alert.alert-error') } #不应该再出现错误提示信息
      end #after visiting another page
    end #With Invalid Information
    
    #使用有效信息登陆了  包括let的使用
    describe "With valid information"do
      let(:user){FactoryGirl.create(:user)} #先将FG实例化
      before do  #测试之前
        fill_in "Email", with: user.email #使用FG实例化时用的email和密码
        fill_in "Password", with: user.password
        click_button "Sign in" #点击Sign in按钮
      end
      it { should have_selector('title',text: user.name) } #title have be view your username
      it { should have_link('Users', href: users_path) } #header have be view the link.
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) } 
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) } #don't have view the sign_link
      describe "followed by signout" do #再点击登出
        before { click_link "Sign out" } #测试之前先点击 Sign out按钮
        it { should have_link('Sign in') } #应该又可以重新看到登陆按钮了
      end
    end #With valid information
  end #signin
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      	describe "in the Users controller" do
	  describe "visiting the user index" do
	    before { visit users_path} 
	    it { should have_selector('title',text: "Sign in") } 
	  end#user index
      	  describe "visting the edit page" do
      	    before { visit edit_user_path(user) }
            it { should have_selector('title', text: "Sign in") } 
      	  end#visting the edit page
          describe "submitting to the update action" do
            before { put user_path(user) }
            specify { response.should redirect_to(signin_path) }
          end#sumitting to the update action
      	end#in the Users controller
    end#for non-signed-in users
    describe "as wrong user" do
      let(:user2) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user2 }

      describe "visiting self edit pages" do
        before { visit edit_user_path(user2) }
        it { should have_selector('h1', text:'Update your profile') } #访问自己的编辑页面应该是ok的
      end #其实这一步可以证明user2已经登陆成功了 

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }#访问别人编辑页面的时候应该是失败的
        it { should_not have_selector('title', text: full_title('Edit user')) }
        it { should have_selector('title', text: full_title('')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        it { should_not have_link('Sign in', href: signin_path) } #如果登陆成功的话 应该会看不到sign－in的链接的
        it { should have_link('Sign out', href: signout_path) } #看的到sign－out ，并且看不到sign-in的链接时也证明已经处于登陆状态了
        specify { response.should redirect_to(root_path) }
      end
    end
    
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
           describe "when signing in again" do
            before do
              #delete signout_path
              click_link "Sign out"
              #visit signin_path
              click_link "Sign in"
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end#when signing in again"
            it "should render the default (profile) page" do
              page.should have_selector('title', text: user.name) 
            end
          end#should render the desired protected page
        end#after signing in
      end#when attempting to visit a protected page
    end#for non-signed-in users

    #非admin用户是无法删除别的user的
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin } 
      #使用非admin用户登陆
      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) } #当提交一个delete请求的时候应该被转回首页
        specify { response.should redirect_to(root_path) }        
      end
    end

  end#authorization

end#"AuthenticationPages
