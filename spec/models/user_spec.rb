# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#

require 'spec_helper'

describe User do
  before do
     @user = User.new(name:"exampleuser",email:"user@example.com",password:"foobar",password_confirmation:"foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) } #Tests for an admin attribute. 
  it { should respond_to(:authenticate) }  
  it { should_not be_admin } #Tests for an admin attribute. admin属性不应该是True
  it { should be_valid }

  describe "when name is not present"do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present"do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long"do
    before { @user.name = "a"*51 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "When email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save #不区分大小写敏感 重复就报错!!!
    end
    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase # should be lower save as db!
    end
  end

#--- About Password
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "When password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it {should_not be_valid}
  end

  describe "When password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it {should_not be_valid}
  end

  describe "When password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it {should_not be_valid}
  end

  describe "return value of authenticate method" do
      before { @user.save } #在save之前
      let(:found_user) { User.find_by_email(@user.email) } #by email去查找一个user。找到的user
      # let可以被用来测试内部变量 比如 :found_user
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end # it { should ---> @user.should || authenticate放内存放的是密码 通过密码查找 返回的是一个user的全部信息

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") } # 使用一个错误的密码
      it { should_not == user_for_invalid_password } #返回的:user_for_invalid_password 用户应该和@user 不是一个人
      specify { user_for_invalid_password.should be_false } #明确提示[specify] 无效的用户密码应该是无效的
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  #-- 是我，无聊的注释条
  #---/ 设置admin属性为True
  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
      #--/ toggle! 方法可以让一个属性从false变成true
    end

    it { should be_admin }
  end

end
