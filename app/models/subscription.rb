class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :challenge_id

  belongs_to :challenge, class_name: "Challenge"
  belongs_to :participant, class_name: "Participant"

end
