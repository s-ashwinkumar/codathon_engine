class DashboardsController < ApplicationController
	def index
		@challenges = Challenge.order('challenges.start_date DESC').all
		@avg_scores = average_scores
		@member_engagement = Challenge.member_engagement
		@total_submissions = 0
		@member_engagement = (@member_engagement.map{|e| e[1]}.sum).to_f / @member_engagement.count
		@current_challenge = params[:challenge_id].present? ? Challenge.find_by_id(params[:challenge_id]) : Challenge.currently_running
		@current_questions = @current_challenge.questions unless @current_challenge.blank?
		if !@current_questions.blank?
			@chart_data = {
			    labels: [],
			    datasets: [],
			    results: []
			}
			((@current_challenge.start_date.to_date)..(@current_challenge.end_date.to_date)).each do |da|
				@chart_data[:labels].push(da.to_s)
			end
			@current_questions.each do |cq|
				sub_date = []
			  @chart_data[:labels].each {|label| sub_date.push(cq.submissions.collect{|s| s.created_at.to_date}.count(label.to_date))}
			  @chart_data[:datasets] << sub_date
			  @chart_data[:results] << cq.submissions_result
			end
		end
		if request.xhr?
			render :partial => "dashboard_data", :locals => { data: @data}
		end
	end

	def average_score_charts
		@response = {}
		challenges = Challenge.last(10)
		@response[:challenge_names] = challenges.collect{|ch| ch.title}
		@response[:total_point] = challenges.collect{|ch| ch.total_points}
		@response[:top_scores] = []
		@response[:avg_scores] = []
		@response[:average_overall_score] = average_scores[0]
		avg_scores = []
		challenges.each do |ch|
			user_scores = ch.user_scores  #{user_id => total_score_for_challenge}
			@response[:top_scores].push(user_scores.max_by{|k,v| v}.try(:last).to_f)
			@response[:avg_scores].push( user_scores.blank? ? 0 : (user_scores.values.sum.to_f / user_scores.size) )
		end
		render :partial => "average_score_charts"
	end

	def individual_score_chart
		@response = {}
		@response[:user_scores] = {}
		@response[:user_questions_scores] = []
		@response[:challenge] = Challenge.find_by_id(params[:challenge_id])

		render :partial => "individual_score_chart"
	end

	def engagement_charts
		@response = {}
		member_engagement = Challenge.member_engagement
		@total_submissions = 0
		@response[:overall_engagement] = (member_engagement.map{|e| e[1]}.sum).to_f / member_engagement.count
		challenges = Challenge.last(10)
		@response[:challenge_names] = challenges.collect{|ch| ch.title}
		@response[:engagements] = challenges.collect{|ch| ch.member_engagement}
		render :partial => "engagement_charts"
	end


	private

	def average_scores(challenge_id = nil)
		if current_user.admin?
			if challenge_id
				challenge_engagement = Challenge.member_engagement(challenge_id)[0][1]
				challenge_questions = Challenge.find(challenge_id).questions
				total_points = challenge_questions.collect{|q| q.points.to_i}.sum
				total_scores = 0
				challenge_questions.each do |chq|
					total_scores += chq.score
				end
				avg_score = (challenge_engagement == 0 ? 0 : total_scores.to_f / challenge_engagement)
				[avg_score, total_points]
			else
				total_points = Challenge.all.collect{|c| c.questions.collect{|q| q.points.to_i}}.flatten.sum
				total_scores = Challenge.all.collect{|c| c.questions.collect{|q| q.score}}.flatten.sum
				challenges_engagement = Challenge.member_engagement.collect{|e| e[1]}.sum
				avg_score = (challenges_engagement == 0 ? 0 : total_scores.to_f / challenges_engagement)
				[avg_score, total_points]
			end
		else
			challenge_count = Challenge.all.select{|chal| chal.attempted_by_current_user?(current_user)}.count
			total_points_user = Challenge.all.collect{|chal| chal.user_scores[current_user.id].to_i}.inject(:+)
			average_score = total_points_user.to_f / challenge_count
			[average_score, challenge_count]
		end
	end
end
