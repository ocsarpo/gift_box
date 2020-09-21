require 'test_helper'
module Lotto::V1
  class DrawsControllerTest < ActionDispatch::IntegrationTest
    test "random" do
      get v1_draw_random_path

      mock = Minitest::Mock.new
      mock.expect :random, [1,2,3,4,5,6]
      retval = DrawService.stub :new, mock do
        mock.random
      end

      assert_mock mock

      json = JSON(response.body)
      assert_equal json.length, retval.length
    end

    test "draw" do
      get v1_draw_path

      mock = Minitest::Mock.new
      mock.expect :draw, [1,2,3,4,5,6]
      retval = DrawService.stub :new, mock do
        mock.draw
      end

      assert_mock mock

      json = JSON(response.body)
      assert_equal json.length, retval.length
    end
  end
end