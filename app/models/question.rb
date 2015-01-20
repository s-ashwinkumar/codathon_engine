class Question < ActiveRecord::Base
  attr_accessible :challenge_id, :description, :title

  belongs_to :challenge
  has_many :submissions
  has_many :question_test_cases

  def create_submission(current_user, result)
  	submissions.create(result: result,score: calculate_score(result),user_id: current_user.id)
  end

 	def calculate_score(result)
 		end_score = result ? points : 0
 	end

 	def update_question_with_test_cases(obj,test_cases)
 		update_attributes(obj)
 		test_cases.each do |index,ele|
 			if question_test_cases[index.to_i]
 				question_test_cases[index.to_i].update_attributes(ele)
 			elsif !ele["points"].empty?
 				QuestionTestCase.create(ele.merge(:question_id => id))
 			end
 		end if test_cases
 	end

 	def self.create_with_test_cases(obj, test_cases)
 		q = create(obj)
 		test_cases.each do |index, ele|
 			if q.question_test_cases[index]
 				q.question_test_cases[index].update_attributes(ele)
 			elsif !ele["points"].empty?
 				QuestionTestCase.create(ele.merge(:question_id => q.id))
 			end
 		end if test_cases
 	end
end
