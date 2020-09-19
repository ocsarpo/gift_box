require 'test_helper'

class LottoNumberTest < ActiveSupport::TestCase
  def setup
    @number = LottoNumber.new
  end

  test "should not save number without num" do
    assert_not @number.save
  end

  test "should not save number without name" do
    @number.num = 4
    assert_not @number.save
  end

  test "number must unique" do
    number1 = lotto_numbers(:one)
    _number1 = LottoNumber.new
    _number1.num = 1
    _number1.name = "1번"

    assert_not _number1.save
  end
  
  test "number greater than 0, less than 46" do
    @number.num = 0
    @number.name = "0번"
    @number.save

    assert_equal @number.errors[:num], ["must be greater than 0"]
    
    @number.num = 46
    @number.save
    assert_equal @number.errors[:num], ["must be less than 46"]
  end

  test "picked_nums_counter increment by 1" do
    num = lotto_numbers(:one)
    round = rounds(:one)

    assert_difference 'num.picked_nums_count' do
      num.picked_nums.create(round: round)
    end
  end

  test "increase bonus number" do
    num = lotto_numbers(:one)

    assert_difference 'num.bonus_count' do
      num.increase_bonus_count
    end
  end

  test "only_wins_count" do
    drawed = @number.picked_nums_count
    bonus = @number.bonus_count
    only_wins = drawed - bonus

    assert_equal @number.wins_only_count, only_wins
  end
  
  test "details" do
    ln = lotto_numbers(:one)
    details = ln.details 

    selected = %w(id num)
    details.reject!{|k| selected.include? k}

    assert details.empty?    
  end

  def teardown
    PickedNum.delete_all
    LottoNumber.delete_all
  end
end