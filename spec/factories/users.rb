FactoryBot.define do

  factory :user do
    # id { '1' }
    name { 'zzz' }
    email { 'zzz@mail.com' }
    password { 'zzzzzz' }
    password_confirmation { 'zzzzzz' }
  end

  factory :second_user, class: User do
    # id { '1' }
    name { 'yyy' }
    email { 'yyy@mail.com' }
    password { 'yyyyyy' }
    password_confirmation { 'yyyyyy' }
  end

end
