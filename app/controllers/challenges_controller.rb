class ChallengesController < ApplicationController

	def index
		@challenges = Challenge.order("active DESC, start_date DESC").paginate(:page => params[:page], :per_page => 10)
	end

	def finish
		challenge_id = params[:challenge_id]
		ch = Challenge.find_by_id(challenge_id)
		render :text => "Challenge not found", :status => 500 and return unless ch
		ch.update_attribute(:end_date, Time.now)
		ch.update_attribute(:active, false)
		render :text => "Challenge closed successfully", :status => 200 and return
	end

	def load_modal
		challenge_id = params[:challenge_id]
		ch = Challenge.find_by_id(challenge_id)
		@question = ch.questions.first || Question.new
		respond_to do |format|
    		format.js { render :partial => "questions_list_in_modal", :locals => { challenge: ch } }
  		end
	end

	def save_challenge
		debugger
	end
end
