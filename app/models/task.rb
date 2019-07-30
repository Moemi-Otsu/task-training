class Task < ApplicationRecord
  belongs_to :user
  has_many :labels, dependent: :destroy

  # 内容が空／同じものの重複
  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 101 }
  validates :deadline, presence: true

  # クラスメソッドと同じことになる
  scope :status_search_param, -> (status_search){where(status: status_search)}
  scope :priority_search_param, -> (priority_search){where(priority: priority_search)}
  scope :title_search_ambiguous, -> (title_search){where("title LIKE?", "%#{title_search}%")}
end
