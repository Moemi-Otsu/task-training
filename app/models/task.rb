class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  # アソシエーションメソッド - タスクに付いたラベルを取得する label は単数系
  has_many :labels_on_task, through: :task_labels, source: :label

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 101 }
  validates :deadline, presence: true

  scope :status_search_param, -> (status_search){where(status: status_search)}
  scope :priority_search_param, -> (priority_search){where(priority: priority_search)}
  scope :title_search_ambiguous, -> (title_search){where("title LIKE?", "%#{title_search}%")}
end
