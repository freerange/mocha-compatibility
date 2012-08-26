require File.expand_path('../test_helper', __FILE__)

require "minitest/unit"
require "minitest/autorun"

require "active_support"
require "shared_adapter_tests"

require "test_runner"
TestRunner.test_base_class = ActiveSupport::TestCase

class ActiveSupportTest < MiniTest::Unit::TestCase
  include SharedAdapterTests
end
