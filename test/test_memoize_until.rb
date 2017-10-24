require 'minitest/autorun'
require 'memoize_until'
require 'concurrent'

class MemoizeUntilTest < Minitest::Test

	def test_thread_safety
		clear_all_values
		latch = Concurrent::CountDownLatch.new(1)
		Thread.new { latch.wait; memoize_day(:default) { "hello world" } }
		Thread.new { latch.wait; memoize_min(:default) { "hello world" } }
		Thread.new { latch.wait; memoize_month(:default) { "hello world" } }
		latch.count_down
	end

	def test_basic_functionality
		return_val = memoize_day(:default) { "hello world" }
		assert_equal return_val, "hello world"
		return_val = memoize_day(:default) { 123 } # doesn't eval the block again
		assert_equal return_val, "hello world"
	end

	def test_memoization_expiration
		return_val = memoize_min(:default) { "hello world" }
		assert_equal return_val, "hello world"
		sleep(60)
		return_val = memoize_min(:default) { "hello world 2" }
		assert_equal return_val, "hello world 2"
	end

	private

	def memoize_day(key)
		MemoizeUntil.day(key) {
			yield
		}
	end

	def memoize_min(key)
		MemoizeUntil.min(key) {
			yield
		}
	end

	def memoize_month(key)
		MemoizeUntil.month(key) {
			yield
		}
	end

	def clear_all_values
		clear_day
		clear_min
		clear_month
	end

	def clear_day
		MemoizeUntil::DAY.clear_all(:default)
	end

	def clear_min
		MemoizeUntil::MIN.clear_all(:default)
	end

	def clear_month
		MemoizeUntil::MONTH.clear_all(:default)
	end

end