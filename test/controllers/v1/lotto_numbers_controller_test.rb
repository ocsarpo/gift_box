require 'test_helper'

class V1::LottoNumbersControllerTest < ActionDispatch::IntegrationTest
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

    lotto_num1 = JSON(ln.to_json)
    json = JSON(response.body)    

    assert_equal json, lotto_num1
  end

end
