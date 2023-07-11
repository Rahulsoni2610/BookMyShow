class CreateBookTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :book_tickets do |t|
      t.string :alphanumeric_id
      t.integer :total_tickets

      t.timestamps
    end
  end
end
