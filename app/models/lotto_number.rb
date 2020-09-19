class LottoNumber < ApplicationRecord
  has_many :picked_nums, dependent: :destroy

  validates :num, :name, presence: true
  validates :num, uniqueness: true
  validates :num, numericality: {only_integer: true, greater_than: 0, less_than: 46}
  
  def details
    selects = %w[id num]
    JSON(self.to_json).select! { |k| selects.include? k }
  end

  def wins_only_count
    self.picked_nums_count - self.bonus_count
  end

  def increase_bonus_count
    self.bonus_count += 1
    self.save
  end
end