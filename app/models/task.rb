class Task < ApplicationRecord
  # 内容が空／同じものの重複
  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 101 }
  validates :deadline, presence: true

  scope :status_search_param, -> (status_search){where(status: status_search)}
  scope :title_search_ambiguous, -> (title_search){where("title LIKE?", "%#{title_search}%")}
end
