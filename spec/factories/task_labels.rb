FactoryBot.define do

  # タスク作成時にラベル付与
  factory :task_label do
    task_id { 1 }
    label_id { 1 }
  end

  # factory :second_task_label, class: TaskLabel do
  #   task { '1' }
  #   label { '2' }
  # end

end
