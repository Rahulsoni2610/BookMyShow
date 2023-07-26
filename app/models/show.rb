class Show < ApplicationRecord
	belongs_to :movie
	belongs_to :screen
	has_many :book_tickets, dependent: :destroy

	validates :start_time, :end_time, :movie_id, presence: true
	validates :screen_id, presence: true , uniqueness: true
end
