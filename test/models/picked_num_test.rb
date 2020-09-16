
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

  test "increase lotto_number bonus count after bonus picked_num create" do
    @picked.lotto_number = lotto_numbers(:one)
    @picked.round = rounds(:one)
    @picked.bonus = true

    assert_difference '@picked.lotto_number.bonus_count' do
      @picked.save!
    end
  end

  def teardown
    PickedNum.delete_all
  end
end