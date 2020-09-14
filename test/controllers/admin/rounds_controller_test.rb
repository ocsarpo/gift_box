require 'test_helper'

class Admin::RoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_round = rounds(:one)
  end

  test "should get index" do
    get admin_rounds_url, as: :json
    assert_response :success
  end

  test "should create admin_round" do
    assert_difference('Round.count') do
      post admin_rounds_path, params: { round: { round: 1, draw: Time.zone.now } }, as: :json
    end

    assert_response 201
  end

  test "should show admin_round" do
    get admin_round_url(@admin_round), as: :json
    assert_response :success
  end

  test "should update admin_round" do
    patch admin_round_url(@admin_round), params: { round: { round: 1, draw: Time.zone.now } }, as: :json
    assert_response 200
  end

  test "should destroy admin_round" do
    assert_difference('Round.count', -1) do
      delete admin_round_url(@admin_round), as: :json
    end

    assert_response 204
  end
end
