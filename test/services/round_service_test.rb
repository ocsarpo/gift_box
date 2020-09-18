require 'test_helper'

class RoundServiceTest < ActiveSupport::TestCase
  def setup
    @round_service = RoundService.new
  end

  test 'get rounds picked_nums' do
    round = rounds(:one)

    numbers = @round_service.wins_info(round)

    assert_equal numbers[:round], round.round
    assert_equal numbers[:wins].sort, [1,2,3,4,5,6]
    assert_equal numbers[:bonus], 7
  end

  test 'draws_rate' do
    ln = lotto_numbers(:one)
    round = Round.last.round
    percent = ln.wins_only_count / round.to_f * 100.0
    percent = percent.round(3)
    result = @round_service.draws_rate(ln, round)
    
    assert_equal percent, result
  end
end