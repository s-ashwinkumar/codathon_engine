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
    ques = Question.find_by_id(params[:question_id])
    test_case = ques.question_test_cases[params[:test_case_index].to_i] if ques
    if ques && test_case
      test_case.delete
      render :json => {:question_id => ques.id, :test_case_index => params[:test_case_index]}, :status => 200
    else
      render :text => "Error!", :status => 500
    end
  end

end
