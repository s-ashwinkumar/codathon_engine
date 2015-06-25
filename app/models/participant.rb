class Participant < User
  # attr_accessible :title, :body
  has_many :wins, class_name: "Challenge", foreign_key: "winner_id"
  has_many :challenges, through: :subscriptions, foreign_key: "user_id"
end
