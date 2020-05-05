class MemoizeUntil
  class Store
    attr_reader :_store, :_kind

    def initialize(kind)
      @_store = {}
      @_kind = kind
    end

    # returns the value from memory if already memoized for "now" for the given key
    # else evaluates the block and memoizes that
    # caches nils too
    def fetch(key, &block)
      now = Time.now.public_send(_kind)
      value = get(key, now)
      unless value
        clear_all(key)
        value = set(key, now, yield)
      end
      unset_nil(value)
    end

    # add runtime keys
    def add(key)
      _store[key] ||= {}
    end

    # clears all previously memoized values for the given key
    # only clears memory in the process that this code runs.
    # added for fetch and custom scripts
    def clear_all(key)
      _store[key] = {}
    end

    # clears previously memoized value for "now" for the given key
    # only clears memory in the process that this code runs.
    # added for custom scripts
    def clear_now(key)
      now = Time.now.public_send(_kind)
      _store[key][now] = nil
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
      _store[key][now] = set_nil(value)
    end

    def get(key, now)
      purpose = _store[key]
      raise NotImplementedError unless purpose
      purpose[now]
    end
  end
end