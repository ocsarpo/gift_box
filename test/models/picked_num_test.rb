
require 'test_helper'

class PickedNumTest < ActiveSupport::TestCase
  def setup
    @picked = PickedNum.new
  end

  test "should not save without fk" do    
    @picked.round = rounds(:one)

    assert_not @picked.valid?
    assert @picked.errors.messages[:lotto_number].any?
  end

  test "should not save without round" do
    @picked.lotto_number = lotto_numbers(:one)

    assert_not @picked.valid?
    assert @picked.errors.messages[:round].any?
  end
  # test "the truth" do
  #   assert true
  # end
end