class Label < ApplicationRecord
  belongs_to :tasks, optional: true
  has_many :task_labels, dependent: :destroy
  # label.task_labels_tasks
  # メソッドとして使える - ラベルをつけたタスクの情報
  # has_many :task_labels_tasks, through: :task_labels, source: :task
end
