class Challenge < ActiveRecord::Base
  attr_accessible :active, :end_date, :start_date, :title

  has_many :questions

  accepts_nested_attributes_for :questions
  scope :active, where(:active => true).order('start_date desc')

  def self.currently_running
  	Challenge.active.where("start_date <= NOW() and end_date >= NOW() ").first
  end

  def start_and_end_time_html
  	(start_date.strftime("%b %d, %Y %I:%M %p") + " to " + end_date.strftime("%b %d, %Y %I:%M %p")).html_safe
  end

end
