require 'yaml'
class MemoizeUntil
	
	class Store

		def self.set(key, moment, value)
			@key_val[key][moment] = value
		end

		def self.get(key, moment)
			@key_val[key][moment]
		end

		def self.clear_all(key)
			@key_val[key].clear
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

	if defined?(Rails) && File.exists?("#{Rails.root}/config/memoize_until.yml")
		load_path = "#{Rails.root}/config/memoize_until.yml"
	else
		load_path = "#{__dir__}/memoize_until/config.yml"
	end
	memoizable_attributes = YAML.load_file(load_path)

	memoizable_attributes.each do |kind, keys|
		klass = const_set(kind.upcase, Class.new(Store))
		klass.class_eval do
			@key_val = {}
			keys.each { |key|
				@key_val[key] = {}
			}
		end

		define_singleton_method(kind) do |key, &block|
			klass.send(:fetch, key, kind, &block)
		end

	end
end

unless Time.instance_methods.include?(:week)
	# returns number representing the nth week of the month
	class Time
		def week
			self.day / 7
		end
	end
end