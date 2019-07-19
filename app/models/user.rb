class User < ApplicationRecord
  validates: name, presense: true, length: { maximum: 30 }
  validates: email, presense: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
