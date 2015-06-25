class CreateQuestionTestCases < ActiveRecord::Migration
  def change
    create_table :question_test_cases do |t|
      t.integer :question_id
      t.integer :points
      
      t.timestamps
    end
  end
end
