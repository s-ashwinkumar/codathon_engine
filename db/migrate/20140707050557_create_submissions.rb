class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.boolean :result
      t.integer :score
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
