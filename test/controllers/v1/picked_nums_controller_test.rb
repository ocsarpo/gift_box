require 'test_helper'

class V1::PickedNumsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get v1_picked_nums_path
    assert_response :ok
  end

  test "create" do
    post v1_picked_nums_path(picked_num: {
      lotto_number: lotto_numbers(:one),
      round: 1
    })

    assert_response :created
  end

  test "destroy exist entity" do
    delete v1_picked_num_path(picked_nums(:one))

    assert_response :ok
  end

  test "destroy non exist entity" do
    delete v1_picked_num_path(10000)

    assert_response :unprocessable_entity
  end

  # test "the truth" do
  #   assert true
  # end
end
