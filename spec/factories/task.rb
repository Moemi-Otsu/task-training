# FactoryBotを使用します
FactoryBot.define do

  factory :task do
    title { 'タイトルaタイトルa' }
    content { 'コンテンツaコンテンツaコンテンツa' }
    deadline { '2019-07-27' }
  end

  factory :second_task, class: Task do
    title { 'タイトルbタイトルb' }
    content { 'コンテンツbコンテンツbコンテンツb' }
    deadline { '2019-07-30' }
  end

  factory :third_task, class: Task do
    title { 'タイトルcタイトルc' }
    content { 'コンテンツcコンテンツcコンテンツc' }
    deadline { '2019-08-08' }
  end

end