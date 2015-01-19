class Question < ActiveRecord::Base
  attr_accessible :challenge_id, :description, :points, :title, :test_case_output

  belongs_to :challenge
  has_many :submissions

  def create_submission(current_user, result)
  	submissions.create(result: result,score: calculate_score(result),user_id: current_user.id)
  end

 	def calculate_score(result)
 		end_score = result ? points : 0
 	end
end
