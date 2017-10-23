require 'minitest/autorun'
require 'memoize_until'

class MemoizeUntilTest < Minitest::Test
  def test_english_hello
    assert_equal "hello world", "hello world"
  end
end