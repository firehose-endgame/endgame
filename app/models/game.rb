class Game < ApplicationRecord
	belongs_to :user
	has_many :pieces

  validates :name, presence: true, length: { minimum: 2 }
end
