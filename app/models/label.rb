class Label < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :tasks
end
