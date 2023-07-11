class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.references :screen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
