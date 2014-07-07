class Challenge < ActiveRecord::Base
  attr_accessible :active, :end_date, :start_date, :title

  has_many :questions
end
