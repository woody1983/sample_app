FactoryGirl.define do
  factory :user do
    #name     "Factory Girl"
    #email    "michael@example.com"
    #使用序列制造批量的测试用户 命名规则如下。
    sequence(:name) {|n| "Person #{n}"}
    sequence(:email) {|n| "Person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    #--/ 我是权限分割的管理员
    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

end
#before(:all) { 30.times { FactoryGirl.create(:user) } }
#在测试之前先创建30个测试用户数据
#after(:all)  { User.delete_all }
#在测试之后 删除这些测试用户数据
