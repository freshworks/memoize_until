$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'yaml'

# copy requires from the railtie here
require 'memoize_until/store'
require 'memoize_until/base'

# require extensions
require 'memoize_until/extensions'

# patches
unless Time.instance_methods.include?(:week)
    require 'memoize_until/time_patch'
end

require 'concurrent'
require "minitest/autorun"