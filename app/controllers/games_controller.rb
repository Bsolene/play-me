class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: [:index, :search, :show]

  def search
    @games = Game.where(name: params[:name])
  end

  def index
    @games = Game.all
    @user = current_user
  end

  def show
    @challenge = Challenge.new
    @user = @game.user.email
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    if current_user != @game.user
      redirect_to root_path
    end
  end

  def update
    if current_user == @game.user
      @game.update(game_params)
      redirect_to game_path(@game)
    else
      redirect_to root_path
    end
  end

  def delete
    if current_user == @game.user
      @game.destroy
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :picture_url, :stake)
  end

end
