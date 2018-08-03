class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
  		t.string :title
      t.string :reason
      t.datetime :date

      t.datetime :created_at
      t.datetime :updated_at
  	end
  end
end
