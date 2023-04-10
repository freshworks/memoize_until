# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
version = File.read(File.expand_path('VERSION', __dir__)).strip

Gem::Specification.new do |spec|
  spec.name          = 'memoize_until'
  spec.version       = version
  spec.authors       = ['Ritikesh']
  spec.email         = ['ritikesh.ganpathraj@freshworks.com']

  spec.summary       = 'Local Memoization Pattern!'
  spec.description   = 'Local Memoization Pattern to store complex and repeated computations in memory until the next hour/day/week'
  spec.homepage      = 'https://github.com/freshdesk/memoize_until'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.required_ruby_version = '~> 2.6.9'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/freshdesk/memoize_until'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'concurrent-ruby', '~> 1.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 1.49'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.30.0'
end
