class AddRefToTheaters < ActiveRecord::Migration[7.0]
  def change
    add_reference :theaters, :user, null: false, foreign_key: true
  end
end
