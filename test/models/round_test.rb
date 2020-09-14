require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  
  def setup
    @round = Round.new
  end

  test "round should greater than 0" do
    @round.round = 0
    @round.draw = Time.zone.now
    assert_not @round.valid?
    assert @round.errors.messages[:round].any?
  end

  test "draw must presence" do
    @round.round = 1
    @round.draw = nil
    @round.save
    assert_not @round.valid?
    assert @round.errors.messages[:draw].any?
  end

  test "round must unique" do
    @round.round = rounds(:one).round
    @round.draw = Time.zone.now

    assert_not @round.valid?
    assert @round.errors.messages[:round].any?
  end

  test "picked_num is nested attributes of round" do
    @round.round = 1
    @round.draw = Time.zone.now
    @round.picked_nums.build([{lotto_number: lotto_numbers(:one)}, {lotto_number: lotto_numbers(:two)}])

    assert_equal @round.picked_nums.first.round.round, @round.picked_nums.second.round.round 
  end

  def teardown
    Round.delete_all
  end
end
