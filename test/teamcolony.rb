require "minitest/autorun"
require 'dotenv'

require_relative '../teamcolony'
require_relative 'test_helper'

class TestTeamColony < Minitest::Test
  def setup
    require 'dotenv'
    Dotenv.load
    @tc = TeamColony.new
    stub_get
  end

  def test_fetch_without_param
    reports = @tc.fetch()
    assert(reports.size > 0)
  end

  def test_fetch_with_just_from
    reports = @tc.fetch('yesterday')
    assert(reports.size > 0)
  end

  def test_fetch_with_both_boundaries
    reports = @tc.fetch('2015-01-01', 'today')
    assert(reports.size > 0)
  end

  def test_fetch_for_future
    stub_get('empty')
    reports = @tc.fetch('tomorrow', 'tomorrow')
    assert_empty(reports)
  end
end