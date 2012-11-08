require 'spec_helper'
=begin
id:001 登陆页面的基本组件显示
id:002 使用无效信息登陆
id:003 错误提示信息只在当前页面上显示 不影响其他页面
id:004 使用有效信息登陆
id:005 登陆成功以后Link和页面信息的测试
id:006 登陆成功后的退出测试
---authorization
id:007 未登陆用户不能访问User列表 & 不能进入User编辑页面 & 不能PUT User修改信息 并且都转向到signin页面
id:008 已登陆User可以访问自己的信息编辑页面 但不能访问和PUT信息到别人的页面中 & 如果PUT应转向到网站首页
id:009 针对未登录User 如果访问受保护页面 将其转向到signin页面 完成signin动作后转向到其希望到达的页面 desired protected page
id:010 在已登陆状态下点击登出再登陆进系统的时候应该直接转向到个人页面 而不是上一次希望访问的页面
id:011 未登录状态下 提交Micropost和删除Micropost 都应该转向到Signin页面
id:012 非Administrator的User是无法删除User信息的
=end

describe "AuthenticationPages" do
  subject { page }  
#--------------------------先page这个对象 subject出来。因为该测试主要是测试页面上的属性为主
  describe "sign in page" do #-----------------------------------------------------------------------------------+-[id:001]
    before { visit signin_path } #测试之前 先访问这个登陆页面
    it { should have_selector('h1',text:'Sign in') } #应该可以看到这些字样
    it { should have_selector('title',text:'Sign in') }
  end 
#--------------------------登陆页面的显示，Title和H1标题之类的。#sign in page------↑----------------------

  describe "signin"do
    before { visit signin_path } 
    describe "With Invalid Information"do #-----------------------------------------------------------------------+-[id:002] 
      before { click_button "Sign in" } #测试之前先点击 sign in
      it { should have_selector('title',text:'Sign in') } #应该还是会出现提示sign的字样
      it { should have_selector('div.alert.alert-error', text: 'Invalid') } #显示无效invalid字样
    #----------------------------基本测试，什么都不填写的情况下应该还是返回signin页面显示invalid信息-----
      describe "after visiting another page" do #-----------------------------------------------------------------+-[id:003] 
        before { click_link "Home" } #比如home主页
        it { should_not have_selector('div.alert.alert-error') } #不应该再出现错误提示信息
      end 
    #-------------额外的测试---#after visiting another page
    end
  #↑-----------------------------------------------------------使用无效信息 #With Invalid Information
    
    describe "With valid information"do #-------------------------------------------------------------------------+-[id:004]
      let(:user){FactoryGirl.create(:user)} #先将FG实例化
      before do  #测试之前
        fill_in "Email", with: user.email #使用FG实例化时用的email和密码
        fill_in "Password", with: user.password
        click_button "Sign in" #点击Sign in按钮
      end
    #-----------------填写有效信息在指定的栏位上-------------------------↑----------------------------------------+-[id:005]
      it { should have_selector('title',text: user.name) } #title have be view your username
      it { should have_link('Users', href: users_path) } #header have be view the link.
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) } 
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) } #don't have view the sign_link
    #-----------------页面和link的显示测试------------------------------------------↑----------------------
      describe "followed by signout" do #--------------------------------------------------------------------------+-[id:006]
        before { click_link "Sign out" } #测试之前先点击 Sign out按钮
        it { should have_link('Sign in') } #应该又可以重新看到登陆按钮了
      end
    #-------------登陆成功后的登出测试---是否又显示可以sign-in的link-----------↑---------followed by signout
    end 
  #↑---------------------------------------------------------使用有效信息登陆--#With valid information-----
  end 
  #----------------------#signin---------------------登陆基本功能---------------------------------------------
  
  
  #----------------------↓--------------authorization 测试开始----------↓----------------------------#
  describe "authorization" do 
    describe "for non-signed-in users" do 
      let(:user) { FactoryGirl.create(:user) }
        describe "in the Users controller" do  #-------------------------------------------------------------------+-[id:007]
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
        #it { should have_selector('title',text: "Sign in") } 
        specify { response.should redirect_to(signin_path) }
      end#sumitting to the update action
        end#in the Users controller
    end
  #----------------------------------未登录的用户---#for non-signed-in users----↑--------------------------------
    describe "as wrong user" do #------------------------------------------------------------------------------------+-[id:008]
      let(:user2) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user2 }#创建2个User 使用其中一个User2登陆

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
  #----------------------------------as wrong user--其他用户-----------------↑--------------------------------
    
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) } #只创建User 并未登陆

      describe "when attempting to visit a protected page" do 
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end #访问受保护页面被拒绝 转向到signin页面 填写信息 signin
        describe "after signing in" do
          it "should render the desired protected page" do #--------------------------------------------------------+-[id:009]
            page.should have_selector('title', text: 'Edit user')
          end
           describe "when signing in again" do #--------------------------------------------------------------------+-[id:010]
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

      describe "in the Microposts controller" do #--------------------------------------------------------------------+-[id:011]

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(signin_path) }
        end
      end#--------------↑------in the Microposts controller
    end
  #-------------------------针对未登录User #for non-signed-in users----------------↑-------
    
    describe "as non-admin user" do #----------------------------------------------------------------------------------+-[id:012]
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin } #使用非admin用户登陆      
      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) } #当提交一个delete请求的时候应该被转回首页
        specify { response.should redirect_to(root_path) }        
      end
    end
  #---------非admin用户是无法删除别的user的-------------as non-admin user----------↑-----

  end#authorization
  #----------------------↑--------------authorization 测试结束----------↑----------------------------#

end#"AuthenticationPages