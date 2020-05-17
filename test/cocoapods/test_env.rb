require "minitest/autorun"
require "cocoapods/env"

class CocoapodsEnvTest < Minitest::Test

  def test_it_returns_expected_version
    assert_equal CocoapodsEnv::VERSION, '0.1.0'
  end

  def test_it_contains_user_defined_install_options
    options = Pod::Command::Install.options
    assert_includes options, [
      '--user-defined-{key}=value', 'Adds user defined flags that can be accessed inside the Podfile'
    ]
  end

  def test_it_sets_user_defined_option
    argv = CLAide::ARGV.new(["--option-a", "--user-defined-test123=value"])
    command = Pod::Command::Install.new(argv)
    assert_equal Pod::Podfile::DSL.user_defined_options[:test123], "value"
  end

  def test_it_parses_user_defined_true_string_to_boolean
    argv = CLAide::ARGV.new(["--option-a", "--user-defined-test123=true"])
    command = Pod::Command::Install.new(argv)
    assert_equal Pod::Podfile::DSL.user_defined_options[:test123], true
  end

  def test_it_parses_user_defined_false_string_to_boolean
    argv = CLAide::ARGV.new(["--option-a", "--user-defined-test123=false"])
    command = Pod::Command::Install.new(argv)
    assert_equal Pod::Podfile::DSL.user_defined_options[:test123], false
  end

  def test_it_parses_multiple_user_defined_options
    argv = CLAide::ARGV.new(["--user-defined-test123=ABC", "--user-defined-test456=false"])
    command = Pod::Command::Install.new(argv)
    assert_equal Pod::Podfile::DSL.user_defined_options[:test123], "ABC"
    assert_equal Pod::Podfile::DSL.user_defined_options[:test456], false
  end

end