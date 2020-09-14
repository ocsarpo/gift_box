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
end
