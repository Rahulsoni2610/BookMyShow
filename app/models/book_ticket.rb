class BookTicket < ApplicationRecord
	belongs_to :user
	belongs_to :movie

	validates :total_tickets,:movie_id,numericality: true, presence: true
	validates :theater_name, presence: true

	before_save :ticket_id

	def ticket_id
		self.alphanumeric_id = SecureRandom.hex[0..5]
	end
end






