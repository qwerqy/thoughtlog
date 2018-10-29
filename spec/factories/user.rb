FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { "johndoe@example.com" }
    password { "abcd1234"}
    about { 'lorem ipsum' }
    location { 'zimbabwe' }
  end
end
