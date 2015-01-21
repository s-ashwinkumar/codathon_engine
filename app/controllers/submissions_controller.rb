class SubmissionsController < ApplicationController
  
  #CAS Authentication Docs : https://github.com/rubycas/rubycas-client#using-rubycas-client-in-rails-controllers
  
  before_filter :check_loggedin

  def check_loggedin
    if !(session[:cas_user])
      redirect_to '/'
    end
  end

  def validate_submission
    @test_case_id = params["test_case_id"]
    @input_file = params["solution_file"]
    begin
      qtc = QuestionTestCase.find(@test_case_id)
      sub = Submission.create(:user_id => current_user.id, :question_test_case_id => qtc.id, :solution_file => @input_file)
      if sub 
        if FileUtils.identical?(sub.solution_file.path,qtc.output_file.path)
          sub.update_attributes(:result=>true, :score=>qtc.points)
          render status: 200
        else
          sub.update_attributes(:result=>false, :score=>0)
          render status: 200
        end
      else
        @invalid = true
      end
    rescue Exception => e
      invalid_submission = Submission.find_by_user_and_question_test_case(current_user,QuestionTestCase.find_by_id(@test_case_id))
      invalid_submission.destroy if invalid_submission
      @invalid=true
    ensure

    end
    
    # question_id = params["question_id"]
    # solution = params["solution"]
    # question = Question.find_by_id(question_id)
    # if question
    #   if question.test_case_output.gsub("\r","").strip == solution.strip
    #     flag = true
    #   end
    #   question.create_submission(current_user,flag.present?)
    #   if flag
    #     render :json => {:text => "Sahi jawab boss !!!", :question_id => question.id}, :status => 200 and return
    #   else
    #     render :json => {:text => "ROFL !!! You thought THAT was right !!!", :question_id => question.id}, :status => 200 and return
    #   end
    # else
    #   render :text => "Something went wrong !!!", :status => 500 and return
    # end
  end
end
