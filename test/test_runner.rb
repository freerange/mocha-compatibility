require 'test/unit/testcase'

module TestRunner
  class << self
    attr_accessor :test_base_class
  end

  def run_as_test(&block)
    run_as_tests(:test_me => block)
  end

  def run_as_tests(methods = {})
    test_class = Class.new(TestRunner.test_base_class) do
      methods.each do |(method_name, proc)|
        define_method(method_name, proc)
      end
    end
    tests = methods.keys.select { |m| m.to_s[/^test/] }.map { |m| test_class.new(m) }

    if defined?(MiniTest::Unit::TestCase) && TestRunner.test_base_class.ancestors.include?(MiniTest::Unit::TestCase)
      require "mini_test_result"
      runner = MiniTest::Unit.new
      tests.each do |test|
        test.run(runner)
      end
      test_result = MiniTestResult.new(runner, tests)
    elsif defined?(Test::Unit::TestCase) && TestRunner.test_base_class.ancestors.include?(Test::Unit::TestCase)
      require "test_unit_result"
      test_result = TestUnitResult.build_test_result
      tests.each do |test|
        test.run(test_result) {}
      end
    else 
      raise "*** no suitable test runner available ***"
    end

    test_result
  end

  def assert_passed(test_result)
    flunk "Test failed unexpectedly with errors: #{test_result.error_messages}" if test_result.error_count > 0
    flunk "Test failed unexpectedly with failures: #{test_result.failure_messages}" if test_result.failure_count > 0
  end

  def assert_failed(test_result)
    flunk "Test failed with unexpected errors: #{test_result.error_messages}" if test_result.error_count > 0
    flunk "Test passed unexpectedly" unless test_result.failure_count > 0
  end

  def assert_errored(test_result)
    flunk "Test failed with unexpected failures: #{test_result.failure_messages}" if test_result.failure_count > 0
    flunk "Test passed unexpectedly" unless test_result.error_count > 0
  end

end
