require File.expand_path('../test_helper', __FILE__)

require "test/unit"

require "active_support"
require "shared_adapter_tests"

require "test_runner"
TestRunner.test_base_class = ActiveSupport::TestCase

class ActiveSupportTest < Test::Unit::TestCase
  include SharedAdapterTests
end
