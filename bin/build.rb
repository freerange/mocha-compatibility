#!/usr/bin/env ruby

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

def run_tests(options = {})
  prefixes = ["MOCHA_OPTIONS=debug"]
  prefixes << %{REQUIRE_ACTIVESUPPORT="#{options[:activesupport]}"} if options[:activesupport]
  prefixes << %{REQUIRE_MINITEST="#{options[:minitest]}"} if options[:minitest]
  prefixes << %{REQUIRE_TESTUNIT="#{options[:testunit]}"} if options[:testunit]
  prefixes << %{REQUIRE_MOCHA="#{options[:mocha]}"} if options[:mocha]
  execute("#{prefixes.join(' ')} bundle install")
  execute("#{prefixes.join(' ')} bundle exec rake")
end

run_tests(activesupport: "gem 'activesupport', '~> 3.2'", mocha: "gem 'mocha'")
