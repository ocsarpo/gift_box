require 'test_helper'

class LottoNumberServiceTest < ActiveSupport::TestCase
  def setup
    @ln = lotto_numbers(:one)
    @ln_service = LottoNumberService.new(@ln)
  end

  test 'details' do
    result = @ln_service.details
    
    assert_equal @ln.draw_probability, result[:odds]
  end
end