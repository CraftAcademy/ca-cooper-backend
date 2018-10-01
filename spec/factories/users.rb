FactoryBot.define do
  factory :user do
    email { "MyString@random.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
