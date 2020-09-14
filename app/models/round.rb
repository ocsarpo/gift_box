class Round < ApplicationRecord
  has_many :picked_num, dependent: :destroy

  validates :round, :draw, presence: true
  validates :round, numericality: {only_integer: true, greater_than: 0}
end
