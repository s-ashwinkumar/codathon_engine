class User < ActiveRecord::Base
  set_inheritance_column 'role'
  attr_accessible :active, :email, :emp_id, :full_name, :role, :user_name

  has_many :submissions

  def self.check_for_user(session)
  	user_hash = {:user_name => session[:cas_user] ,:full_name => session[:cas_extra_attributes]["cn"][0],:active => true,:email => session[:cas_extra_attributes]["mail"][0],:emp_id => -1,:role => 'Participant'}
  	user = User.where("user_name = ?",user_hash[:user_name]).first_or_create!(user_hash)
  end

end
