require "bundler"
require "bundler/setup"

require 'rake/testtask'

task "test" do
  Rake::Task[ENV["RAKE_TEST_TASK"]].invoke
end

namespace "test" do
  Rake::TestTask.new("mini_test") do |t|
    t.libs << 'test'
    t.test_files = FileList['test/active_support_mini_test_test.rb']
    t.verbose = true
    t.warning = true
  end

  Rake::TestTask.new("test_unit") do |t|
    t.libs << 'test'
    t.test_files = FileList['test/active_support_test_unit_test.rb']
    t.verbose = true
    t.warning = true
  end
end
