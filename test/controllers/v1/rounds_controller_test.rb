require 'test_helper'

class V1::RoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @v1_round = rounds(:one)
  end

  test "should get index" do
    get v1_rounds_url, as: :json
    json = JSON(response.body)
    last = JSON(rounds(:last).wins_info.to_json)

    assert_response :success
    assert_equal json, last
  end

  test "should show v1_round" do
    get v1_round_url(@v1_round), as: :json
    assert_response :success
  end

end
