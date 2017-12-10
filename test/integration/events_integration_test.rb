require 'minitest_helper'

describe 'Events integration' do
  it 'shows the event title' do
    event = Event.create!(title: 'Whatever')
    visit events_path(event)
    page.text.must_include "Whatever"
  end
end
