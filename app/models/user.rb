class User < ActiveRecord::Base
  set_inheritance_column 'role'
  attr_accessible :active, :email, :emp_id, :full_name, :role, :user_name

  has_many :submissions

  def self.check_for_user(session)
  	user_hash = {:user_name => session[:cas_user] ,:full_name => session[:cas_extra_attributes]["cn"][0],:active => true,:email => session[:cas_extra_attributes]["mail"][0],:emp_id => -1,:role => 'Participant'}
  	user = User.where("user_name = ?",user_hash[:user_name]).first_or_create!(user_hash)
  end	

  def self.dashboard_data(month ,year)
  	from_date  = DateTime.new(year || Time.now.year, month || Time.now.month).beginning_of_month
  	to_date  = DateTime.new(year || Time.now.year, month || Time.now.month).end_of_month
  	result_array = []
  	Participant.all.each do | user |
  		h = { :name => user.full_name}
  	    submissions = user.submissions.where("created_at > ? and created_at < ? and score != 0 ",from_date,to_date)
  		h[:score] = submissions.group(:question_id).collect(&:score).inject(&:+)
  		h[:submissions] = submissions.count
  		result_array << h
  	end	
  	result_array
  end	
end
