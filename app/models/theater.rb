class Theater < ApplicationRecord

  belongs_to :user
  has_many :screens, dependent: :destroy
  has_many :shows, through: :screens, dependent: :destroy

  validates :name, presence: true
  validates :location, uniqueness: true, presence: true

end
