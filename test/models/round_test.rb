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
    @round.picked_nums.build([
      {lotto_number: lotto_numbers(:one)},
      {lotto_number: lotto_numbers(:two)}
      ])

    assert_equal @round.picked_nums.first.round.round,
                  @round.picked_nums.second.round.round 
  end

  test "wins_info" do
    mock = Minitest::Mock.new
    round = rounds(:last)
    # https://semaphoreci.com/community/tutorials/mocking-in-ruby-with-minitest
    # https://docs.ruby-lang.org/en/2.0.0/MiniTest/Mock.html
    mock.expect :wins_info, {
      round: round.round, wins: [1,2,3,4,5,6], bonus: 7
    }, [round]

    retval = RoundService.stub :new, mock do
      mock.wins_info(round)
    end
    
    assert_equal retval[:round], round.round
    assert_equal retval[:wins].sort, [1,2,3,4,5,6]
    assert_equal retval[:bonus], 7

    assert_mock mock
    # assert mock.verify # assert_mock 내부에서 검증함
  end

  test "paging" do
    offset = 0
    limit = 1
    rounds = Round.page(offset, limit,
              "id, round, draw", "draw", "desc")
    assert_equal rounds.size, 1

    offset = 0
    limit = 100
    rounds = Round.page(offset, limit,
              "id, round, draw", "draw", "desc")
    assert_equal rounds.size, 10

    offset = 0
    limit = 100
    rounds = Round.page(offset, limit,
              "id, round, draw", "draw", "desc", 11)
    assert_equal rounds.size, 11
  end

  def teardown
    PickedNum.delete_all
    Round.delete_all
  end
end
