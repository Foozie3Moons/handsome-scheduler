require 'minitest_helper'

class EventTest < Minitest::Test
  def test_whatever
    event = Event.new(title: 'Whatever')
    assert_equal 'Whatever', event.title
  end
end
