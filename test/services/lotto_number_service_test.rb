require 'test_helper'

class LottoNumberServiceTest < ActiveSupport::TestCase
  def setup
    @ln = lotto_numbers(:one)
    @ln_service = LottoNumberService.new(@ln)
  end

  test 'details' do
    round = Round.last.round
    percent = @ln.wins_only_count / round.to_f * 100.0
    percent = percent.round(3)

    result = @ln_service.details
    
    assert_equal percent, result[:odds]
  end
end