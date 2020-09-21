require 'test_helper'

module Admin::Lotto
  class RoundsImportsControllerTest < ActionDispatch::IntegrationTest
    test "should get new" do
      get new_admin_rounds_import_path
      assert_response :success
    end

    test "should get create" do
      name = 'files/lotto_for_test.xlsx'
      mime = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'             
      bulk_file = fixture_file_upload(name, mime)

      # 테스트 엑셀 수가 11라인
      assert_difference('Round.count', 11) do
        post admin_rounds_imports_path, params: {rounds_import: {file: bulk_file}}
      end    
      
      assert_response :created
    end
  end
end