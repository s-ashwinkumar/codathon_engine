class QuestionController < ApplicationController
  
  #CAS Authentication Docs : https://github.com/rubycas/rubycas-client#using-rubycas-client-in-rails-controllers
  
  # before_filter :check_loggedin

  # def check_loggedin
  # 	if !(session[:cas_user])
  # 		redirect_to '/'
  # 	end
  # end

  def index
    Rails.logger.info "***************** #{session.inspect}"
  end

end
