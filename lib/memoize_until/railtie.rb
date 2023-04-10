# frozen_string_literal: true

class MemoizeUntil
  class Railtie < Rails::Railtie
    initializer 'memoize_until.config_hook' do
      # initialising the memoize_until classes
      require 'memoize_until/base'

      # require extensions
      require 'memoize_until/extensions'

      # patches
      require 'memoize_until/time_patch'
    end
  end
end
