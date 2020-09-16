class PickedNum < ApplicationRecord
  belongs_to :lotto_number, counter_cache: true
  belongs_to :round
  before_save :bonus_number, if: :is_create?

  validates :lotto_number, :round, presence: true

private
  def is_create?
    self.id.nil?
  end

  def bonus_number
    self.lotto_number.increase_bonus_count if self.bonus
  end
end