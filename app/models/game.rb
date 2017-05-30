class Game < ApplicationRecord
  belongs_to :user
  has_many :challenges
  has_attachment :picture

  TITLES = ['Fifa17', 'Cs', 'Madden 17', 'NBA 2K17', 'Tekken 7', 'Overwatch', 'Call of Duty: Modern Warfare' ]
  validates :stake, presence: true, numericality: { only_integer: true, greater_than: 0 }
end

