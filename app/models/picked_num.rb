class PickedNum < ApplicationRecord
  belongs_to :lotto_number, counter_cache: true

  validates :lotto_number, :round, presence: true
  validates :round, numericality: {only_integer: true, greater_than: 0}
end