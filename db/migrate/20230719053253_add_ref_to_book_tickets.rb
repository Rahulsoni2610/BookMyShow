class AddRefToBookTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :book_tickets, :theater, null: false, foreign_key: true
  end
end
