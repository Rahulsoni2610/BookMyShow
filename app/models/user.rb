class User < ApplicationRecord
	has_one_attached :image 
	has_many :theaters, dependent: :destroy
	has_many :book_tickets , dependent: :destroy
	has_many :screens , through: :theaters , dependent: :destroy
	  
	validates :name,presence: true, length: {minimum:2, maximum:10} , format: {without: /\d/}
	validates :email,presence: true , uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
	validates :password ,presence: true , length: {minimum:2, maximum:8}
	validates :type , presence: true

	def owner?
		type == "Owner"
	end

	def customer?
		type == "Customer"
	end
end
