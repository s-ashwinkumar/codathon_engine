class AddAttachmentInputFileOutputFileToQuestionTestCases < ActiveRecord::Migration
  def self.up
    change_table :question_test_cases do |t|
      t.attachment :input_file
      t.attachment :output_file
    end
  end

  def self.down
    remove_attachment :question_test_cases, :input_file
    remove_attachment :question_test_cases, :output_file
  end
end
