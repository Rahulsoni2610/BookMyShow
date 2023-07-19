class Screen < ApplicationRecord
  belongs_to :theater
  belongs_to :movie

	validates :name,:total_seats, presence: true
	validates :total_seats , length: {maximum:40}
	validates :movie_id , presence: true


	

end
