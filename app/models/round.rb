class Round < ApplicationRecord
  include Pageable

  has_many :picked_nums, dependent: :destroy
  accepts_nested_attributes_for :picked_nums

  validates :round, :draw, presence: true
  validates :round, numericality: {only_integer: true, greater_than: 0}
  validates :round, uniqueness: true

  def self.last
    order(round: :desc).first
  end

  def self.first
    order(round: :asc).first
  end
end
