class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :points
      t.integer :challenge_id

      t.timestamps
    end
  end
end
