class QuestionTestCase < ActiveRecord::Base
  attr_accessible :question_id, :points, :input_file, :output_file

  belongs_to :question
	has_many	:submissions

  has_attached_file :input_file
  has_attached_file :output_file

  validates_attachment :input_file, :presence => true,
  :content_type => { :content_type => "text/plain" }
  validates_attachment :output_file, :presence => true,
  :content_type => { :content_type => "text/plain" }
end
