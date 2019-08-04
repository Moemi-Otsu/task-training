class Label < ApplicationRecord
  belongs_to :tasks, optional: true
  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels, source: :task

  validates :label_name, uniqueness: true
end
