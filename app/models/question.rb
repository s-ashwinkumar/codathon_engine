class Question < ActiveRecord::Base
  attr_accessible :challenge_id, :description, :points, :title

  belongs_to :challenge
  has_many :submissions
end
