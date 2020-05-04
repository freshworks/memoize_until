# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
version = File.read(File.expand_path("VERSION", __dir__)).strip

Gem::Specification.new do |spec|
  spec.name          = "memoize_until"
  spec.version       = version
  spec.authors       = ["Ritikesh"]
  spec.email         = ["ritikesh.ganpathraj@freshworks.com"]

  spec.summary       = %q{Local Memoization Pattern!}
  spec.description   = %q{Local Memoization Pattern to store complex and repeated computations in memory until the next hour/day/week}
  spec.homepage      = "https://github.com/freshdesk/memoize_until"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/freshdesk/memoize_until"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'concurrent-ruby', '~> 1.0'
  spec.add_development_dependency "minitest", "~> 5.0"
end
