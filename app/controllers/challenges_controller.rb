class ChallengesController < ApplicationController
	layout "participant", :only => :user_index

	def index
		redirect_to user_index_path if !session[:user].is_a?Admin
		@challenges = Challenge.order("active DESC, created_at DESC").paginate(:page => params[:page], :per_page => 10)
	end

	def user_index
		@submissions = Submission.live_feed
		@current_challenge = Challenge.currently_running
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

	def load_datepicker
		challenge = Challenge.find(params[:challenge_id])
		start_date=challenge.start_date.strftime('%m/%d/%Y %l:%M %p').to_s
		end_date=challenge.end_date.strftime('%m/%d/%Y %l:%M %p').to_s
		render :partial => "load_datepicker", :locals => { challenge: challenge, start_date: start_date, end_date: end_date }
	end

	def schedule
		start_time = DateTime.strptime(params[:start_time], '%m/%d/%Y %l:%M %p')
		end_time = DateTime.strptime(params[:end_time], '%m/%d/%Y %l:%M %p')
		challenge = Challenge.find(params[:challenge_id])
		if challenge && start_time.present? && end_time.present?
			challenge.update_attribute(:start_date, start_time)
			challenge.update_attribute(:end_date, end_time)
			render :text => "Challenge scheduled successfully", :status => 200 and return
		else
			render :text => "Something went wrong !!!", :status => 500 and return
		end
	end

	def create
		Challenge.create({:title => params[:title], :start_date => Time.at(params[:start_date].to_i/1000), :end_date => Time.at(params[:end_date].to_i/1000), :active => true})
		render :text => "Challenge created successfully", :status => 200 
	end	

end
