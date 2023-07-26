class AddRefToShow < ActiveRecord::Migration[7.0]
  def change
    add_reference :shows, :movie, null: false, foreign_key: true
    add_reference :shows, :screen, null: false, foreign_key: true
  end
end
