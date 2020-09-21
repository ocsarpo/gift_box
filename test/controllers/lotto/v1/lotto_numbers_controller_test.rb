require 'test_helper'

module Lotto::V1
  class LottoNumbersControllerTest < ActionDispatch::IntegrationTest
    test "index" do
      get v1_lotto_numbers_path
      assert_response :ok

      json = JSON(response.body)  
      lotto_num1 = JSON(lotto_numbers(:one).to_json)
      lotto_num2 = JSON(lotto_numbers(:two).to_json)

      assert_includes json, lotto_num1
      assert_includes json, lotto_num2
    end

    test "show" do
      ln = lotto_numbers(:one)
      get v1_lotto_number_path(ln)
      assert_response :ok
      
      mock = Minitest::Mock.new    
      mock.expect :details, {
              id: ln.id,
              num: ln.num,
              wins: ln.wins_only_count,
              bonus: ln.bonus_count,
              odds: ln.draw_probability.to_s
            }
      retval = LottoNumberService.stub :new, mock do
        mock.details
      end

      assert_mock mock

      json = JSON(response.body)

      assert_equal json["id"], retval[:id]
      assert_equal json["wins"], retval[:wins]
      assert_equal json["odds"], retval[:odds]
    end
  end
end