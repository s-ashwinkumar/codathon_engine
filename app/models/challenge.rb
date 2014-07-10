class Challenge < ActiveRecord::Base
  attr_accessible :active, :end_date, :start_date, :title

  has_many :questions

  accepts_nested_attributes_for :questions
  scope :active, where(:active => true).order('start_date desc')

  def self.currently_running
  	Challenge.active.where("start_date <= NOW() and end_date >= NOW() ").first
  end

end
