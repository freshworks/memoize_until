class MemoizeUntil

	memoizable_attributes = YAML.load_file("#{__dir__}/config/defaults.yml")
	
	if defined?(Rails) && File.exists?("#{Rails.root}/config/memoize_until.yml")
		memoizable_attributes.deep_merge!(YAML.load_file("#{Rails.root}/config/memoize_until.yml"))
	end
	
	KLASS_MAP = {}
	
	memoizable_attributes.each do |kind, keys|
		
		klass = const_set(kind.upcase, Class.new(Store))
		klass.init!
		
		keys.each { |key|
			klass.extend(key)
		}
		
		define_singleton_method(kind) do |key, &block|
			klass.fetch(key, kind, &block)
		end

		KLASS_MAP[kind] = klass
		
	end

	def self.extend(kind, key)
		KLASS_MAP[kind].extend(key)
	end
end
