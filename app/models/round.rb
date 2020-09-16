class Round < ApplicationRecord
  has_many :picked_nums, dependent: :destroy
  accepts_nested_attributes_for :picked_nums

  validates :round, :draw, presence: true
  validates :round, numericality: {only_integer: true, greater_than: 0}
  validates :round, uniqueness: true

  def wins_info
    retval = RoundService.new.wins_info(self)
  end
end
