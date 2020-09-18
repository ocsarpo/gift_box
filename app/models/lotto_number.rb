class LottoNumber < ApplicationRecord
  has_many :picked_nums, dependent: :destroy

  validates :num, :name, presence: true
  validates :num, uniqueness: true
  validates :num, numericality: {only_integer: true, greater_than: 0, less_than: 46}
  
  def draws_rate
    round = Round.last.round # TODO cache로 관리
    percent = RoundService.new.draws_rate(self, round)

    {
      wins: wins_only_count,
      total: round,
      percent: percent    
    }    
  end

  def wins_only_count
    self.picked_nums_count - self.bonus_count
  end

  def increase_bonus_count
    self.bonus_count += 1
    self.save
  end
end