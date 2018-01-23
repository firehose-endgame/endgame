class Game < ApplicationRecord
	belongs_to :user
	has_many :pieces

	scope :available, -> { where("user_id IS NOT NULL and opponent_id IS NULL") }

  validates :name, presence: true, length: { minimum: 2 }
  scope :available, -> { where(:opponent_id => nil) }
end
