require './lib/memoize_until/version'

Gem::Specification.new do |s|
  s.name          = %q{memoize_until}
  s.version       = MemoizeUntil::VERSION
  s.date          = Time.now.utc.strftime("%Y-%m-%d")
  s.summary       = %q{Local Memoization Pattern!}
  s.description   = %q{Local Memoization Pattern to store complex and repeated computations in memory until the next hour/day/week}
  s.authors       = ["Ritikesh G"]
  s.email         = %q{ritikesh.ganpathraj@freshworks.com}
  s.files         = ["lib/memoize_until.rb", "lib/memoize_until/config.yml", "lib/memoize_until/patch.rb", "lib/memoize_until/store.rb"]
  s.require_paths = ["lib"]
  s.homepage      = %q{http://rubygems.org/gems/memoize_until}
  s.license       = %q{MIT}
  s.add_development_dependency 'concurrent-ruby', '~> 1.0'
  s.add_development_dependency 'minitest', '~> 5.0'
end