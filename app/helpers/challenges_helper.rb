module ChallengesHelper

  def options_for_winners(challenge)
    options_for_select(challenge.participants.map{|usr| [usr.full_name,usr.id]})
  end
end
