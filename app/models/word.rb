class Word < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :body, presence: true, length: { maximum: 50 }
end
