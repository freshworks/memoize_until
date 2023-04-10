# frozen_string_literal: true

class MemoizeUntil
  class Store
    attr_reader :_store, :_kind, :_mutex

    def initialize(kind)
      @_store = {}
      @_kind = kind
      @_mutex = Mutex.new
    end

    # returns the value from memory if already memoized for "now" for the given key
    # else evaluates the block and memoizes that
    # caches nils too
    def fetch(key)
      now = Time.now.public_send(_kind)
      value = get(key, now)

      if value.nil?
        clear_all(key)
        value = set(key, now, set_nil(yield))
      end

      unset_nil(value)
    end

    # add runtime keys
    def add(key)
      _mutex.synchronize do
        _store[key] ||= {}
      end
    end

    # clears all previously memoized values for the given key
    # only clears memory in the process that this code runs.
    # added for supporting fetch and custom scripts
    def clear_all(key)
      _mutex.synchronize do
        _store[key] = {}
      end
    end

    # clears previously memoized value for "now" for the given key
    # only clears memory in the process that this code runs on.
    # added for supporting custom scripts / test cases
    def clear_now(key)
      now = Time.now.public_send(_kind)
      set(key, now, nil)
    end

    private

    # caches nils through a pseudo object
    def set_nil(value)
      value.nil? ? NullObject.instance : value
    end

    # replaces cached pseudo object and returns nil
    def unset_nil(value)
      value.is_a?(NullObject) ? nil : value
    end

    def set(key, now, value)
      _mutex.synchronize do
        _store[key][now] = value
      end
    end

    def get(key, now)
      _mutex.synchronize do
        purpose = _store[key]
        raise NotImplementedError unless purpose

        purpose[now]
      end
    end
  end
end
