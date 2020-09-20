class LottoNumberService
  attr_reader :lotto_number
  
  def initialize(lotto_number)
    @lotto_number = lotto_number
  end

  def details
    @lotto_number.details.merge({
      wins: @lotto_number.wins_only_count,
      bonus: @lotto_number.bonus_count,
      odds: @lotto_number.draw_probability
    })
  end

  private
end