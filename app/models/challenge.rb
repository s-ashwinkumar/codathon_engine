class Challenge < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :description, :finished_at, :winner_id, :owner_id, :created_at, :updated_at
  belongs_to :winner, class_name: "Participant"
  belongs_to :owner, class_name: "Admin"
  has_many :subscriptions, foreign_key: "challenge_id"
  has_many :participants, through: :subscriptions, foreign_key: "user_id"

  def subscriber_names
    participants.collect(&:full_name)
  end

  def finished?
    finished_at.present?
  end

  def created_by?(user)
    owner == user
  end
end
