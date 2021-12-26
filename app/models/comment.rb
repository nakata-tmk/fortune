class Comment < ApplicationRecord
  belongs_to :word

  validates :body, presence: true, length: { maximum: 30 }
end
