# FactoryBotを使用します
FactoryBot.define do

  factory :task do
    title { 'タイトルaタイトルa' }
    content { 'コンテンツaコンテンツaコンテンツa' }
  end

  factory :second_task, class: Task do
    title { 'タイトルbタイトルb' }
    content { 'コンテンツbコンテンツbコンテンツb' }
  end

end