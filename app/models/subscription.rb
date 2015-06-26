class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :challenge_id

  belongs_to :challenge, class_name: "Challenge"
  belongs_to :participant, class_name: "Participant", foreign_key: "user_id"

end
