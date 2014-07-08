module ChallengesHelper

	def disable?(challenge_id)
		Challenge.find(challenge_id).active ? "" : "disabled=disabled"
	end

end
