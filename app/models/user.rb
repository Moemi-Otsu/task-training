class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_destroy :delete_all_users

  private

  def self.delete_all_users
    user_admin = User.where(admin: true)
    if user_admin.size == 1
      errors.add :base, '少なくとも1つ、管理ユーザーアカウントが必要です。'
      return false
    end
  end

end
