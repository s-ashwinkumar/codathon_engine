class Submission < ActiveRecord::Base
  attr_accessible :question_test_case_id, :result, :score, :user_id

  belongs_to :user
  belongs_to :question_test_case

  scope :live_feed, -> { order("id DESC").limit(10) }

  def self.find_by_user_and_question(user, question_test_case)
  	self.find_by_user_id_and_question_test_case_id(user.id, question_test_case.id)
  end
end
