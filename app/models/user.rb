class User < ActiveRecord::Base
  attr_accessible :active, :email, :emp_id, :full_name, :role, :user_name

  has_many :submissions
end
