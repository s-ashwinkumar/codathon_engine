class ChallengesController < ApplicationController

  before_filter :set_current_challenge

  def set_current_challenge
    @challenge = Challenge.find(params["id"])
  end

  def index
  end

  def update
    @challenge.update_attributes(params[:challenge])
    flash[:success] = "Challenge updated successfully !"
    redirect_to challenge_path(@challenge.id)
  end
end
