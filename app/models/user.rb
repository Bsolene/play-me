class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :games
  has_many :challenges#, through: :games
  has_attachment :picture_url
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: true

  def challenges_as_game_owner
    Challenge.where(game: games)
  end
end
