require 'test_helper'

class DrawServiceTest < ActiveSupport::TestCase

  def setup
    @draw_service = DrawService.new
  end

  test 'random draw' do
    assert_equal @draw_service.random.length, 6
  end

  test 'odds draw' do
    assert_equal @draw_service.draw.length, 6
  end
end