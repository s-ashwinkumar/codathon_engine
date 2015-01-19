class SubmissionsController < ApplicationController
  
  #CAS Authentication Docs : https://github.com/rubycas/rubycas-client#using-rubycas-client-in-rails-controllers
  
  before_filter :check_loggedin

  def check_loggedin
  	if !(session[:cas_user])
  		redirect_to '/'
  	end
  end

  def validate_submission
    question_id = params["question_id"]
    solution = params["solution"]
    question = Question.find_by_id(question_id)
    debugger
    if question
      if question.test_case_output.gsub("\r","").strip == solution.strip
        flag = true
      end
      question.create_submission(current_user,flag.present?)
      if flag
        render :text => "Challenge scheduled successfully", :status => 200 and return
      else
        render :text => "Something went wrong !!!", :status => 500 and return
      end
    else
      render :text => "Something went wrong !!!", :status => 500 and return
    end
  end
end
