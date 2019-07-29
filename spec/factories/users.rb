FactoryBot.define do

  factory :user do
    # id { '1' }
    name { 'zzz' }
    email { 'zzz@mail.com' }
    password { 'zzzzzz' }
    password_confirmation { 'zzzzzz' }
    admin { true }
  end

  factory :second_user, class: User do
    # id { '1' }
    name { 'yyy' }
    email { 'yyy@mail.com' }
    password { 'yyyyyy' }
    password_confirmation { 'yyyyyy' }
    admin { false }
  end

  factory :third_user, class: User do
    # id { '1' }
    name { 'qqq' }
    email { 'qqq@mail.com' }
    password { 'qqqqqq' }
    password_confirmation { 'qqqqqq' }
    admin { true }
  end

end
