class MemoizeUntil
    class Store
        class << self
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
                @key_val[key] = {} unless exists?(key)
            end
            alias_method :clear_all, :extend
            private :clear_all

            private

            def exists?(key)
                @key_val[key]
            end

            def set_nil(value)
                value.nil? ? NullObject.instance : value
            end

            def unset_nil(value)
                value.is_a?(NullObject) ? nil : value
            end

            def set(key, moment, value)
                @key_val[key][moment] = set_nil(value)
            end

            def get(key, moment)
                raise NotImplementedError unless exists?(key)
                @key_val[key][moment]
            end

            def clear_for(key, moment)
                @key_val[key][moment] = nil
            end
        end
    end
end