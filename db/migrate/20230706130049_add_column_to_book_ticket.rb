class AddColumnToBookTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :book_tickets, :theater_name, :string
  end
end
