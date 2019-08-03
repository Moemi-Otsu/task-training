class Label < ApplicationRecord
  belongs_to :tasks, optional: true
  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels, source: :task
end
