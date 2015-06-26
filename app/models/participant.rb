class Participant < User
  # attr_accessible :title, :body
  has_many :wins, class_name: "Challenge", foreign_key: "winner_id"
  has_many :subscriptions, foreign_key: "user_id"
  has_many :challenges, through: :subscriptions, foreign_key: "challenge_id"

  def subscribed_to?(challenge_id)
    Subscription.where("challenge_id = ? and user_id = ?",challenge_id,id).present?
  end
end
