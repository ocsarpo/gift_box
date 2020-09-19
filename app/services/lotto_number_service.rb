class LottoNumberService
  attr_reader :lotto_number
  
  def initialize(lotto_number)
    @lotto_number = lotto_number
  end

  def details
    @lotto_number.details.merge({
      wins: @lotto_number.wins_only_count,
      bonus: @lotto_number.bonus_count,
      odds: wins_percent
    })
  end

  private
  def wins_percent
    round = Round.last.round # TODO cache로 관리
    wins_count = @lotto_number.wins_only_count
    (wins_count / round.to_f * 100.0).round(3)
  end
end