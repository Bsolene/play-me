class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:mark_as_accepted]
  before_action :set_game, only: [:create]

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.game = @game
    @challenge.user = current_user
    if @challenge.save
      redirect_to root_path
    else
      render "games/show"
    end
  end

  def mark_as_accepted
    @challenge.update(accepted: true)
    redirect_to :back
  end


  private

  def set_game
    @game = Game.find(params[:game_id])

  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:starts_at, :result, :accepted)
  end

end
