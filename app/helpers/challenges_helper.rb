module ChallengesHelper

	def disable?(challenge_id)
		Challenge.find(challenge_id).active ? "" : "disabled=disabled"
	end

	def get_submission_count(challenge_id)
		Challenge.find(challenge_id).questions.collect(&:submissions).flatten.uniq.count
	end	
end
