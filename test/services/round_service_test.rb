require 'test_helper'

class RoundServiceTest < ActiveSupport::TestCase
  test 'get rounds picked_nums' do
    round = rounds(:one)
    round_service = RoundService.new

    numbers = round_service.wins_info(round)

    assert_equal numbers[:round], round.round
    assert_equal numbers[:wins].sort, [1,2,3,4,5,6]
    assert_equal numbers[:bonus], 7
  end
end