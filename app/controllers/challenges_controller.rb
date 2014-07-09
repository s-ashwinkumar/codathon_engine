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
		(3-ch.questions.size).times {ch.questions.build}
		respond_to do |format|
    		format.js { render :partial => "questions_list_in_modal", :locals => { challenge: ch} }
  		end
	end

	def save_challenge
		challenge = Challenge.find_by_id(params[:challenge_id])
		questions = challenge.questions
		params["challenge"]["questions_attributes"].each do | index,obj |
			if questions[index.to_i]
				questions[index.to_i].update_attributes(obj)
			elsif !obj["title"].empty?
				Question.create(obj.merge(:challenge_id => params[:challenge_id]))
			end		
		end	
		redirect_to '/challenges'
	end
end
