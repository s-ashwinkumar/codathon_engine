class Challenge < ActiveRecord::Base
  attr_accessible :active, :end_date, :start_date, :title

  has_many :questions


  scope :active, where(:active => true).order('start_date desc')

end
