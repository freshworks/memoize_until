class MemoizeUntil

	memoizable_attributes = YAML.load_file("#{__dir__}/config/defaults.yml")
	
	if defined?(Rails) && File.exists?("#{Rails.root}/config/memoize_until.yml")
		memoizable_attributes.deep_merge!(YAML.load_file("#{Rails.root}/config/memoize_until.yml"))
	end

	TYPE_FACTORY = {}
	
	memoizable_attributes.each do |kind, keys|
		
		typed = Store.new(kind)
		
		keys.each { |key|
			typed.add(key)
		}
		
		define_singleton_method(kind) do |key, &block|
			typed.fetch(key, &block)
		end

		TYPE_FACTORY[kind] = typed
		
	end

	def self.add_to(kind, key)
		TYPE_FACTORY[kind].add(key)
	end
end
