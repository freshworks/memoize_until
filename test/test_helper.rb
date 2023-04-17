# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'yaml'

require 'memoize_until/store'

# copy requires from the railtie here
require 'memoize_until/base'
require 'memoize_until/extensions'
require 'memoize_until/time_patch'

require 'concurrent'
require 'minitest/autorun'
