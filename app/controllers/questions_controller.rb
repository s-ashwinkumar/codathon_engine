class QuestionsController < ApplicationController
  
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

  def delete_test_case
    qtc = QuestionTestCase.find_by_id(params[:question_test_case_id])
    if qtc
      qtc.delete
      render :json => {:question_id => qtc.question.id, :test_case_id => qtc.id, :status => 200 }
    else
      render :text => "Error!", :status => 500
    end
  end

end
