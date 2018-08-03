class CreateProject < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
  		t.string :title
      t.integer :budget
      t.integer :manager_id

      t.datetime :created_at
      t.datetime :updated_at
  	end
  end
end
