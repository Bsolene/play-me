class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :games, dependent: :destroy
  has_many :challenges, dependent: :destroy#, through: :games
  has_many :challenges_as_game_owner, through: :games, source: :challenges
  has_attachment :picture
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates :username, uniqueness: true
  after_create :asign_username

  def challenges_as_game_owner
    Challenge.where(game: games)
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.

    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    return user
  end
  # CHALLENGES PLAYED
  def number_of_challenges_played_as_challenger
    challenges.where.not(result: nil).count
  end

  def number_of_challenges_played_as_game_owner
    challenges_as_game_owner.where.not(result: nil).count
  end

  def number_of_challenges_played
    number_of_challenges_played_as_challenger + number_of_challenges_played_as_game_owner
  end
  # WIN
  def number_of_victory_as_game_owner
     challenges_as_game_owner.where(winner: true).count
  end

  def number_of_victory_as_challenger
    challenges.where.not(winner: true).count
  end

  def number_of_victory
    number_of_victory_as_game_owner + number_of_victory_as_challenger
  end

  def percentage_of_victory
    if number_of_victory == 0
      0
    else
    ((number_of_victory.to_f / number_of_challenges_played) * 100).round
    end
  end
  # LOST
  def number_of_losses_as_game_owner
     challenges_as_game_owner.where(winner: false).count
  end

  def number_of_losses_as_challenger
    challenges.where.not(winner: false).count
  end

  def number_of_losses
    number_of_losses_as_game_owner + number_of_losses_as_challenger
  end

  def percentage_of_losses
    if number_of_losses == 0
      0
    else
    ((number_of_losses.to_f / number_of_challenges_played) * 100).round
    end
  end
   # GAMES PLAYED
  def number_of_challenge_as_challenger_for(game_name)
    challenges.where(game_id: Game.where(name: game_name).pluck(:id)).where.not(result: nil).count
  end
  def number_of_challenge_as_game_owner_for(game_name)
    challenges_as_game_owner.where(game_id: Game.where(name: game_name).pluck(:id)).where.not(result: nil).count
  end

  def number_of_challenge_for(game_name)
    number_of_challenge_as_challenger_for(game_name) + number_of_challenge_as_game_owner_for(game_name)
  end
  # MONEY

  def money_as_game_owner_to_add
    challenges_as_game_owner.where(winner: true).map(&:game).map(&:stake).reduce(:+) || 0
  end
  def money_as_challenger_to_add
    challenges.where(winner: false).map(&:game).map(&:stake).reduce(:+) || 0
  end
  def total_money_to_add
    money_as_game_owner_to_add + money_as_challenger_to_add
  end
  def money_as_game_owner_to_sub
    challenges_as_game_owner.where(winner: false).map(&:game).map(&:stake).reduce(:+) || 0
  end
  def money_as_challenger_to_sub
    challenges.where(winner: true).map(&:game).map(&:stake).reduce(:+) || 0
  end
  def total_money_to_sub
    money_as_game_owner_to_sub + money_as_challenger_to_sub
  end
  def total_money
    total_money_to_add - total_money_to_sub
  end


  private

  def asign_username
    if self.username
    else
    self.username = self.first_name
    self.save
    end
  end

end
