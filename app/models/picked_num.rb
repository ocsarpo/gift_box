class PickedNum < ApplicationRecord
  belongs_to :lotto_number, counter_cache: true
  belongs_to :round
  before_save :bonus_number, if: :is_create?
  before_destroy :bonus_decrease
  after_create :probability
  before_destroy :probability

  validates :lotto_number, :round, presence: true

private
  def is_create?
    self.id.nil?
  end

  def bonus_number
    self.lotto_number.increase_bonus_count if self.bonus
  end

  def bonus_decrease
    self.lotto_number.decrease_bonus_count if self.bonus
  end

  def probability
    self.lotto_number.probability
  end
end