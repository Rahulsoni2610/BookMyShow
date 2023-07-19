class RemoveRefFromMovie < ActiveRecord::Migration[7.0]
  def change
    remove_reference :movies, :screen, foreign_key: true
    add_reference  :screens, :movie, foreign_key: true
  end
end
