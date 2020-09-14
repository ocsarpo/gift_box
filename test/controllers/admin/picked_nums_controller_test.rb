require 'test_helper'

class Admin::PickedNumsControllerTest < ActionDispatch::IntegrationTest

  test "index" do
    get admin_picked_nums_path
    assert_response :ok

    json = JSON(response.body)  
    picked_num1 = JSON(picked_nums(:one).to_json)

    assert_includes json, picked_num1
  end

  test "create" do
    post admin_picked_nums_path(picked_num: {
      lotto_number: lotto_numbers(:one),
      round: rounds(:one)
    })

    assert_response :created
  end

  test "destroy exist entity" do
    delete admin_picked_num_path(picked_nums(:one))

    assert_response :ok
  end

  test "destroy non exist entity" do
    delete admin_picked_num_path(10000)

    assert_response :unprocessable_entity
  end
end
