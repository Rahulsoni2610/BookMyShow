class AddRefToBookTicket < ActiveRecord::Migration[7.0]
  def change
    add_reference :book_tickets, :user, null: false, foreign_key: true
    add_reference :book_tickets, :movie, null: false, foreign_key: true
  end
end
