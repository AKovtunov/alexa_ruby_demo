class CreateAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
  		t.string :full_name
      t.datetime :last_checked_date
      t.integer :project_id
      t.string :role
  	end
  end
end
