ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'capybara/rails'

class IntegrationTest < MiniTest::Spec
  # give url helpers to all integration specs
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type /integration$/, self
end
