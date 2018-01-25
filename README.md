# MemoizeUntil

This gem is an extension to the standard `memoization` pattern for storing expensive computations or network calls `in-mmemory`. Unlike other memoization extensions which expire after a pre-defined interval, this gem provides a consistent memoization behavior across multiple processes/servers i.e. keys expire simultaneously across all processes.

Usage:
```ruby
gem install memoize_until
> irb
irb:> require 'memoize_until'
irb:> MemoizeUntil.day(:default) {
irb:> 	PerformSomeComplexOperation
irb:> }
irb:> # memoizes(until the end of the day) and returns the result of #PerformSomeComplexOperation
```

The default API that the gem provides is: `MemoizeUntil#min, MemoizeUntil#hour, MemoizeUntil#day, MemoizeUntil#week, MemoizeUntil#month` with `default` keys. 

To add new keys during run_time, you can also leverage the `extend` API:
```ruby
irb:> MemoizeUntil::DAY.extend(:runtime_key) 
irb:> MemoizeUntil.day(:runtime_key) {
irb:> 	PerformSomeComplexRuntimeOperation
irb:> }
irb:> # memoizes(until the end of the day) and returns the result of #PerformSomeComplexOperation
```
The same can be done for other default classes as well: `MemoizeUntil::MIN, MemoizeUntil::HOUR, MemoizeUntil::WEEK, MemoizeUntil::MONTH`

## Rails

To use this gem in a rails application, add the following line to your `Gemfile` and you are good to go.

```ruby
gem 'memoize_until'
```

For most use cases, the list of keys that come will not suffice. You can define your custom list of config keys that you wish to memoize for, by including a `config/memoize_until.yml` in the root directory of your application. Here is an [example](/examples/memoize_until.yml) to help you with the file structure. 

After creating the memoize_until.yml file, change your `Gemfile` to:
```ruby
gem 'memoize_until', require: false
```
and add the following line anywhere in your application like `application.rb, config/initializers/memoize_until.rb, etc`
```ruby
require 'memoize_until'
```
The caveat here is, memoize_until should be required only after Rails has been initialised. 

To run test cases,
```ruby
ruby -Ilib:test test/memoize_until.rb
```

This project is Licensed under the MIT License. Further details can be found [here](/LICENSE).