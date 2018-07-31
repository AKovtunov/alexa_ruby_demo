class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
  		t.integer :price
      t.integer :account_id
      t.boolean :closed
  	end
  end
end
