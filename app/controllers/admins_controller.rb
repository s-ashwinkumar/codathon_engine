class AdminsController < ApplicationController

  def home
    @challenges = Challenge.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def create_challenge
    Challenge.create(params[:challenge])
    flash[:success] = "Challenge created successfully"
    redirect_to send(get_home_path)
  end

  def admin_page
    @users = Participant.order("full_name DESC").paginate(:page => params[:page], :per_page => 10)
  end
end
