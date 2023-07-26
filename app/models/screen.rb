class Screen < ApplicationRecord
  belongs_to :theater
  has_one :show, dependent: :destroy

	validates :name,:total_seats, presence: true
	validates :total_seats , length: {maximum:40}
  
end
