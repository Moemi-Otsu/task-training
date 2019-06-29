class Task < ApplicationRecord
  # 内容が空／同じものの重複
  validates :title, presence: true, uniqueness: true
end
