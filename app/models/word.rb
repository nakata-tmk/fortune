class Word < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :body, presence: true, length: { maximum: 50 }

  scope :sort_list, -> {
    {
      "並替え" => "",
      "新着順" => "new",
      "古い順" => "old",
      "いいね順" => "favorites"
    }
  }

  def self.sort(selection)
    case selection
      when 'new'
        order(created_at: :DESC)
      when 'old'
        order(created_at: :ASC)
      when 'favorites'
        left_joins(:favorites).group(:id).order('count(favorites.word_id) desc')
    end
  end
end
