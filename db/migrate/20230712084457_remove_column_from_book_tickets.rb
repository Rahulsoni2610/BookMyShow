class RemoveColumnFromBookTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :book_tickets, :theater_name, :string
  end
end
