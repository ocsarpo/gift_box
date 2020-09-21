require 'test_helper'

module Lotto::V1
  class RoundsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @round = rounds(:one)
    end

    test "should get index" do
      page = 1
      get v1_rounds_url(page: page), as: :json
      json = JSON(response.body)

      rounds = Round.page({
        page: page,
        fields: "id, round, draw",      
        order_field: "draw",
        order_method: "desc"      
      })
      rounds = JSON(rounds.to_json)
      
      assert_response :success
      assert_equal json, rounds
    end

    test "should show v1_round" do
      get v1_round_url(@round), as: :json

      mock = Minitest::Mock.new
      mock.expect :wins_info, {
        round: @round.round, wins: [1,2,3,4,5,6], bonus: 7
      }
      retval = RoundService.stub :new, mock do
        mock.wins_info
      end
      
      assert_mock mock

      json = JSON(response.body)

      assert_response :success
      assert_equal json["round"], retval[:round]
      assert_equal json["wins"], retval[:wins]
    end

    test "should show latest round wins_info" do
      get latest_v1_rounds_path, as: :json

      mock = Minitest::Mock.new
      round = rounds(:last)
      mock.expect :wins_info, {
        round: round.round, wins: [1,2,3,4,5,6], bonus: 7
      }
      retval = RoundService.stub :new, mock do
        mock.wins_info
      end
      
      assert_mock mock

      json = JSON(response.body)

      assert_response :success
      assert_equal json["round"], retval[:round]
      assert_equal json["wins"], retval[:wins]
    end

  end
end
    # https://semaphoreci.com/community/tutorials/mocking-in-ruby-with-minitest
    # https://docs.ruby-lang.org/en/2.0.0/MiniTest/Mock.html