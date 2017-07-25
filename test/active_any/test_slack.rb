# frozen_string_literal: true

require 'test_helper'

class ActiveAny::SlackTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ActiveAny::Slack::VERSION
  end
end
