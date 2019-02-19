class MemoizeUntil
    class Store
        
        class << self
            attr_accessor :_store

            def init!
                @_store = {}
            end
            
            def fetch(key, kind, &block)
                now = Time.now.send(kind)
                value = get(key, now)
                unless value
                    clear_all(key)
                    value = set(key, now, yield)
                end
                unset_nil(value)
            end

            def extend(key)
                _store[key] = {} unless exists?(key)
            end
            alias_method :clear_all, :extend
            private :clear_all

            private

            def exists?(key)
                _store[key]
            end

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
                raise NotImplementedError unless exists?(key)
                _store[key][moment]
            end

            def clear_for(key, moment)
                _store[key][moment] = nil
            end
        end
    end
end