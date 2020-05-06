class MemoizeUntil

  memoizable_attributes = YAML.load_file("#{__dir__}/config/defaults.yml")
  
  if defined?(Rails) && File.exists?("#{Rails.root}/config/memoize_until.yml")
    memoizable_attributes.deep_merge!(YAML.load_file("#{Rails.root}/config/memoize_until.yml"))
  end

  TYPE_FACTORY = {}
  private_constant :TYPE_FACTORY
  
  memoizable_attributes.each do |kind, keys|
    
    TYPE_FACTORY[kind] =  Store.new(kind)
    
    keys.each { |key|
      TYPE_FACTORY[kind].add(key)
    }
    
    # Memoizes a complex operation for the pre-specified interval
    #
    # @param key [Symbol] the purpose defined in memoize_until.yml or :default.
    
    # @yield use this block to set the value to be memoized for the given moment
    #
    # @example Memoizing per day.
    #   MemoizeUntil.day(:default) do
    #     # other code
    #   end
    #
    # @return returns the memoized value for the key & moment
    define_singleton_method(kind) do |key, &block|
      TYPE_FACTORY[kind].fetch(key, &block)
    end
    
  end
  
  # Adds a purpose at runtime for the specified kind.
  #
  # @param kind [Symbol] one of the default or customised kind supported
  # @param key [Symbol] the purpose defined in memoize_until.yml or :default.
  #
  # @example Memoizing per day.
  #   MemoizeUntil.add_to(:day, :runtime_key)
  #
  # @return {}
  def self.add_to(kind, key)
    TYPE_FACTORY[kind].add(key)
  end
end
