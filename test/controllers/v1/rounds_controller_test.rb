require 'test_helper'

class V1::RoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @v1_round = rounds(:one)
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
    get v1_round_url(@v1_round), as: :json

    json = JSON(response.body)
    round = JSON(@v1_round.wins_info.to_json)

    assert_equal json, round
    assert_response :success
  end

  test "should show latest round wins_info" do
    get latest_v1_rounds_path, as: :json

    json = JSON(response.body)
    last = JSON(Round.last.wins_info.to_json)
    
    assert_equal json, last
    assert_response :success
  end

end
