# FactoryBotを使用します
FactoryBot.define do

  factory :task do
    title { 'タイトルaタイトルa' }
    content { 'コンテンツaコンテンツaコンテンツa' }
    deadline { '2019-07-27' }
    status { '未着手' }
    priority { '高' }
  end

  factory :second_task, class: Task do
    title { 'タイトルbタイトルb' }
    content { 'コンテンツbコンテンツbコンテンツb' }
    deadline { '2019-07-30' }
    status { '着手' }
    priority { '中' }
  end

  factory :third_task, class: Task do
    title { 'タイトルcタイトルc' }
    content { 'コンテンツcコンテンツcコンテンツc' }
    deadline { '2019-08-08' }
    status { '完了' }
    priority { '低' }
  end

end