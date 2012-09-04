require "bundler"
require "bundler/setup"

require 'rake/testtask'

def execute(command)
  system(command)
  unless $?.success?
    message = [
      "Executing shell command failed.",
      "  Command: #{command}",
      "  Status:  #{$?.exitstatus}"
    ].join("\n")
    raise message
  end
end

task "default" => "test"

task "test" do
  execute "bundle exec rake test:test_unit"
  if (RUBY_VERSION >= "1.9") || ENV["REQUIRE_MINITEST"]
    execute "bundle exec rake test:mini_test"
  end
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
