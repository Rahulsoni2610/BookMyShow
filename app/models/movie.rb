class Movie < ApplicationRecord
  belongs_to :screen
  has_many :book_tickets , dependent: :destroy

  validates :name, presence: true
	validates :screen_id , presence: true#, uniqueness: {message: "A movie is alredy scheduled in screen"}, on: :create

	before_save :set_date

	def set_date
		a = DateTime.now.strftime("%Y/%m/%d")
		self.start_date = a
		b=a.split("/").last.to_i+5
		self.end_date = DateTime.now.strftime("%Y/%m/#{b}")
	end
	
end
