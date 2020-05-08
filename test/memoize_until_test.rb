require "test_helper"

class MemoizeUntilTest < Minitest::Test

	def setup
		clear_all_values
	end

	def test_basic_functionality_with_thread_safety
		latch = Concurrent::CountDownLatch.new(3)
		waiter = Thread.new do
			latch.wait()
			return_val = memoize_day(:default) { "new value" }
			assert_equal return_val, "hello world"
		end
		t1 = Thread.new do
			memoize_day(:default) { "hello world" }
			latch.count_down
		end
		t2 = Thread.new do
			memoize_day(:default) { "hello world" }
			latch.count_down
		end
		t3 = Thread.new do
			memoize_day(:default) { "hello world" }
			latch.count_down
		end
		[waiter, t1, t2, t3].each(&:join)
	end

	def test_exception
		assert_raises MemoizeUntil::NotImplementedError do 
			memoize_day(:exception) { "hello world" }
		end
	end

	def test_nil
		memoize_week(:default) { nil }
		return_val = memoize_week(:default) { 123 }
		assert_nil return_val
	end

	def test_multi_add_to
		MemoizeUntil.add_to(:day, :new_key)
		memoize_day(:new_key) { 1000 }
		MemoizeUntil.add_to(:day, :new_key)
		return_val = memoize_day(:new_key) { 1 }
		assert_equal return_val, 1000
	end

	def test_memoization_expiration
		memoize_min(:default) { "hello world" }
		sleep(60)
		return_val = memoize_min(:default) { "hello world 2" }
		assert_equal return_val, "hello world 2"
	end

	def test_clear_now_for
		return_val = memoize_day(:default) { 1 }
		assert_equal return_val, 1
		MemoizeUntil.clear_now_for(:day, :default)
		return_val = memoize_day(:default) { 2 }
		assert_equal return_val, 2
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

	def memoize_week(key)
		MemoizeUntil.week(key) {
			yield
		}
	end

	def clear_all_values
		clear_day
		clear_min
		clear_week
	end

	def clear_day
		MemoizeUntil.clear_now_for(:day, :default)
	end

	def clear_min
		MemoizeUntil.clear_now_for(:min, :default)
	end

	def clear_week
		MemoizeUntil.clear_now_for(:week, :default)
	end

end