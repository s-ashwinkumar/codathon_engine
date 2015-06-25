class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.datetime :finished_at
      t.integer :winner_id
      t.integer :owner_id
      t.integer :subscription, :default => 0

      t.timestamps
    end
  end
end
