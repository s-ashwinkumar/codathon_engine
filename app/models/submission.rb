class Submission < ActiveRecord::Base
  attr_accessible :question_id, :result, :score, :user_id

  belongs_to :user
  belongs_to :question

  scope :live_feed, -> { order("id DESC").limit(10) }

  def self.find_by_user_and_question(user, question)
  	self.find_by_user_id_and_question_id(user.id, question.id)
  end
end
