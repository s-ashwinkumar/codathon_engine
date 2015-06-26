class ParticipantsController < ApplicationController

  def home
    @challenges = Challenge.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def subscribe
    #method name is misleading. This toggles subscription.
    subscription = Subscription.where("user_id = ? and challenge_id = ?",current_user.id,params[:challenge_id])
    if subscription.present? && subscription.destroy_all
      flash[:success] =  "Unsubscribed from Challenge #{params[:challenge_id]} successfully"
    else
      Subscription.create({user_id: current_user.id, challenge_id: params[:challenge_id]})
      flash[:success] = "Subscribed to Challenge #{params[:challenge_id]} successfully"
    end
    redirect_to send(get_home_path)
  end
end
