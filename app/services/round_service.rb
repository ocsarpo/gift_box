class RoundService
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def wins_info
    picked_nums = @round.picked_nums.includes(:lotto_number)

    {
      round: @round.round,
      wins: wins(picked_nums).sort,
      bonus: bonus(picked_nums)
    }    
  end

private
  def wins(picked_nums)
    picked_nums.reject {|pn| pn.bonus }.map(&:lotto_number).map(&:num)
  end

  def bonus(picked_nums)
    picked_nums.select {|pn| pn.bonus }.first&.lotto_number&.num
  end
end