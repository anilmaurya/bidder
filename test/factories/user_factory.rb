FactoryGirl.define do 
  sequence :username do |n|
    "user#{n}"
  end

  factory :user do
    username
    password '123456'
  end
end
