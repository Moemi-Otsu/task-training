class Task < ApplicationRecord
  # 内容が空／同じものの重複
  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 101 }
  validates :deadline, presence: true
end
