class Task < ApplicationRecord
  validates :description, :status, presence:true
  enum status: [:pending, :complete]
end
