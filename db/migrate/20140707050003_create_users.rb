class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :full_name
      t.string :email
      t.string :role
      t.string :emp_id
      t.boolean :active

      t.timestamps
    end
  end
end
