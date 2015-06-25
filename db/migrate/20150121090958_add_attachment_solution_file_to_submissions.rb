class AddAttachmentSolutionFileToSubmissions < ActiveRecord::Migration
  def self.up
    change_table :submissions do |t|
      t.attachment :solution_file
    end
  end

  def self.down
    remove_attachment :submissions, :solution_file
  end
end
