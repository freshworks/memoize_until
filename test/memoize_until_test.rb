# frozen_string_literal: true

require 'test_helper'

class MemoizeUntilTest < Minitest::Test
  def setup
    clear_all_values
  end

  def test_basic_functionality_with_thread_safety
    threads = []
    1000.times do |n|
      threads << Thread.new do
        memoize_day(:default) { "hello world #{n}" }
      end
    end

    # assert_nothing_raised
    threads.map(&:join)

    return_val = memoize_day(:default) { 1 }

    assert_match(/hello world/, return_val)
  end

  def test_exception
    assert_raises MemoizeUntil::NotImplementedError do
      memoize_day(:exception) { 'hello world' }
    end
  end

  def test_nil
    init_val = memoize_week(:default) { nil }
    return_val = memoize_week(:default) { 123 }

    assert_nil init_val
    assert_nil return_val
  end

  def test_falsy
    init_val = memoize_week(:default) { false }
    return_val = memoize_week(:default) { 123 }

    refute(return_val)
    assert_equal return_val, init_val
  end

  def test_multiple_add_to
    MemoizeUntil.add_to(:day, :new_key)
    memoize_day(:new_key) { 1000 }
    MemoizeUntil.add_to(:day, :new_key)
    return_val = memoize_day(:new_key) { 1 }

    assert_equal(1000, return_val)
  end

  def test_memoization_expiration
    memoize_min(:default) { 'hello world' }
    sleep(60)
    return_val = memoize_min(:default) { 'hello world 2' }

    assert_equal('hello world 2', return_val)
  end

  def test_clear_now_for
    return_val = memoize_day(:default) { 1 }

    assert_equal(1, return_val)
    MemoizeUntil.clear_now_for(:day, :default)
    return_val = memoize_day(:default) { 2 }

    assert_equal(2, return_val)
  end

  private

  def memoize_day(key, &block)
    MemoizeUntil.day(key, &block)
  end

  def memoize_min(key, &block)
    MemoizeUntil.min(key, &block)
  end

  def memoize_week(key, &block)
    MemoizeUntil.week(key, &block)
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
