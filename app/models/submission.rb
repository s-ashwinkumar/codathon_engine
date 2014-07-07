class Submission < ActiveRecord::Base
  attr_accessible :question_id, :result, :score, :user_id

  belongs_to :user
  belongs_to :question
end
