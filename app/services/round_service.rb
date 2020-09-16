class RoundService

  def initialize
    # ...
  end

  def wins_info(round)
    picked_nums = round.picked_nums.includes(:lotto_number)

    {
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