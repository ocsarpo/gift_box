module PageableInterfaceTest
  def test_implements_the_pageable_interface
    assert_respond_to(@object, :page)
  end
end