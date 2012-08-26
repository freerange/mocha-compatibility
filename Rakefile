require "bundler"
require "bundler/setup"

require 'rake/testtask'

task "test" do
  test = ENV["TEST"]
  Rake::Task["test::#{test}"].invoke
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
