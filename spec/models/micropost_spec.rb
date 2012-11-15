# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.create(:user) } #let一个FG
  #before do
    # This code is wrong!???
    #@micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
     before { @micropost = user.microposts.build(content: "Lorem ipsum") }
  #end
  subject { @micropost }

  #micropost 应该含有并返回如下两个属性
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid } #也应该是有效的

  #当没有user信息的时候 应该是无效的post
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: "1")
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

end
