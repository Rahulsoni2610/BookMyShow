class BookTicket < ApplicationRecord
	belongs_to :user
	belongs_to :movie
	belongs_to :theater

	validates :total_tickets,:movie_id,numericality: true, presence: true

	before_save :ticket_id

	def ticket_id
		self.alphanumeric_id = SecureRandom.hex[0..5]
	end
end






