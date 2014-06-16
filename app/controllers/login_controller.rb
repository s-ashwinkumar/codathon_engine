class LoginController < ApplicationController
  
  #before_filter CASClient::Frameworks::Rails::Filter, :except => [ :index ]
  
  def index
	if session[:cas_user]
		redirect_to '/question/index'
	end
	puts "============= #{session[:cas_user]} ================="
  end

end
