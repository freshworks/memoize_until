class MemoizeUntil

	class Store

		class << self

			def set(key, moment, value)
				@key_val[key][moment] = set_nil(value)
			end

			def get(key, moment)
				@key_val[key][moment]
			end

			def clear_all(key)
				@key_val[key] = {}
			end

			def clear_for(key, moment)
				@key_val[key][moment] = nil
			end

			def fetch(key, kind, &block)
				now = Time.now.send(kind)
				value = get(key, now)
				return unset_nil(value) if value
				clear_all(key)
				set(key, now, yield)
			end

			private
				def set_nil(value)
					value.nil? ? NullObject.instance : value
				end

				def unset_nil(value)
					value.is_a?(NullObject) ? nil : value
				end
		end
	end

	class NullObject
		
		def self.instance
			@@null_object ||= NullObject.new
		end

	end

end