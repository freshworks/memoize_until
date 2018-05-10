class MemoizeUntil

	# Rails check is for tests to run without whining about Rails not being defined.
    if defined?(Rails) && File.exists?("#{Rails.root}/config/memoize_until.yml")
		load_path = "#{Rails.root}/config/memoize_until.yml"
	else
		load_path = "#{__dir__}/config/defaults.yml"
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
