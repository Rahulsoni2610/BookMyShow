class Movie < ApplicationRecord
  has_many :shows ,dependent: :destroy

  validates :name, presence: true

	before_save :set_date

	def set_date
		a = DateTime.now.strftime("%Y/%m/%d")
		self.start_date = a
		b=a.split("/").last.to_i+5
		self.end_date = DateTime.now.strftime("%Y/%m/#{b}")
	end
	
end
