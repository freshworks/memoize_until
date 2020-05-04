class MemoizeUntil
  class Store
    attr_reader :_store, :_kind

    def initialize(kind)
      @_store = {}
      @_kind = kind
    end

    def fetch(key, &block)
      now = Time.now.public_send(_kind)
      value = get(key, now)
      unless value
        clear_all(key)
        value = set(key, now, yield)
      end
      unset_nil(value)
    end

    def add(key)
      _store[key] ||= {}
    end

    def clear_all(key)
      _store[key] = {}
    end

    def clear_for(key, moment)
      _store[key][moment] = nil
    end

    private

    def set_nil(value)
      value.nil? ? NullObject.instance : value
    end

    def unset_nil(value)
      value.is_a?(NullObject) ? nil : value
    end

    def set(key, moment, value)
      _store[key][moment] = set_nil(value)
    end

    def get(key, moment)
      purpose = _store[key]
      raise NotImplementedError unless purpose
      purpose[moment]
    end
  end
end