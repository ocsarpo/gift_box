class PickedNum < ApplicationRecord
  belongs_to :lotto_number, counter_cache: true
  belongs_to :round

  validates :lotto_number, :round, presence: true
end