class User < ApplicationRecord
	has_many :theaters, dependent: :destroy
	has_many :book_tickets , dependent: :destroy
	has_many :screens , through: :theaters 
	  
	validates :name,presence: true, length: {minimum:2, maximum:10} , format: {without: /\d/}
	validates :email,presence: true , uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
	validates :password ,presence: true , length: {minimum:2, maximum:8}
end
