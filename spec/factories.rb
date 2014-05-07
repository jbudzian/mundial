FactoryGirl.define do
  factory :user do
    name "Example User"
    email "example.user@sollers.pl"
    password "foobar"
    password_confirmation "foobar"
  end
end