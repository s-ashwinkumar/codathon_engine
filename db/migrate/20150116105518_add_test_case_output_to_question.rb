class AddTestCaseOutputToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :test_case_output, :text
  end
end
