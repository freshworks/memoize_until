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
                _store[key] ||= {}
            end

            private

            def clear_all(key)
                _store[key] = {}
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
                purpose = _store[key]
                raise NotImplementedError unless purpose
                purpose[moment]
            end

            def clear_for(key, moment)
                _store[key][moment] = nil
            end
        end
    end
end