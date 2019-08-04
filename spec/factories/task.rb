# FactoryBotを使用します
FactoryBot.define do

  factory :task do
    title { 'タイトルaタイトルa' }
    content { 'コンテンツaコンテンツaコンテンツa' }
    deadline { '2019-07-27' }
    status { '未着手' }
    priority { '高' }

    # TODO: userを作成する
    # user_id { 1 }

    # after(:create) do |task|
    #   # byebug
    #   # 以下の設定で動く。でもlabelも新規で作成してしまう。
    #   # create(:task_label, task: task, label: create(:label))
    #   # 以下の設定で動く。でもlabelも新規で作成してしまう。
    #   # create(:task_label, task: task, label: create(:label))
    #   # # 以下の設定でconsole上は動くが、実際にRspecを実行してみると動かない。
    #   create(:task_label, task: task, label: Label.find(4))
    #   # byebug
    #   # a.save
    #   # create(:task_label, task: task, label_id: 2)
    # end
  
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

  factory :fourth_task, class: Task do
    title { 'タイトルdタイトルd' }
    content { 'コンテンツdコンテンツdコンテンツd' }
    deadline { '2019-08-21' }
    status { '完了' }
    priority { '低' }
  end

end