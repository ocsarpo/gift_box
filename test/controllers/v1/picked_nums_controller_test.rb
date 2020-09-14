require 'test_helper'

class V1::PickedNumsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get v1_picked_nums_path
    assert_response :ok

    json = JSON(response.body)  
    picked_num1 = JSON(picked_nums(:one).to_json)

    assert_includes json, picked_num1
  end
end
