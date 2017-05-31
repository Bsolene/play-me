class Game < ApplicationRecord
  belongs_to :user
  has_many :challenges
  has_attachment :picture

  GAMES = {
    'Fifa17' => "fifa-banner-2.jpg",
    'Madden 17' => "madden-17.jpg",
    'NBA 2K17' => "nba-card.jpg",
    'Tekken 7' => "tekken-card.jpg",
    'Overwatch' => "overwatch-card.jpg",
    'Call of Duty: Modern Warfare' => "cod-card.jpg",
    'Forza Horizon 3' => "forza-card.jpg"
  }

  validates :stake, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def picture_file_name
    return GAMES[name]
  end

end

