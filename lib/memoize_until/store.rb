class MemoizeUntil

	class Store

		def self.set(key, moment, value)
			@key_val[key][moment] = value
		end

		def self.get(key, moment)
			@key_val[key][moment]
		end

		def self.clear_all(key)
			@key_val[key] = {}
		end

		def self.clear_for(key, moment)
			@key_val[key][moment] = nil
		end

		def self.fetch(key, kind, &block)
			now = Time.now.send(kind)
			value = get(key, now)
			return value if value
			clear_all(key)
			set(key, now, yield)
		end
	end

end