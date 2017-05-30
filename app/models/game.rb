class Game < ApplicationRecord
  belongs_to :user
  has_many :challenges
  TITLES = ['Fifa17', 'Cs', 'Madden 17', 'NBA 2K17', 'Tekken 7', 'Overwatch', 'Call of Duty: Modern Warfare' ]

end

