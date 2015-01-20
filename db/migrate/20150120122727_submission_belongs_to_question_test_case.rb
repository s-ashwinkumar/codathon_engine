class SubmissionBelongsToQuestionTestCase < ActiveRecord::Migration
  def up
  	rename_column :submissions, :question_id, :question_test_case_id
  end

  def down
  	rename_column :submissions, :question_test_case_id, :question_id
  end
end
