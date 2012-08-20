FactoryGirl.define do
  factory :user do
    name     "Factory Girl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
