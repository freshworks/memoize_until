# MemoizeUntil

This gem is an extension to the standard `memoization` pattern for storing expensive computations or network calls `in-memory`. Unlike other memoization extensions which expire after a pre-defined interval, this gem provides a consistent memoization behavior across multiple processes/servers i.e. keys expire simultaneously across all processes.

Usage:
```ruby
gem install memoize_until
> irb
irb:> require 'memoize_until'
irb:> result = MemoizeUntil.day(:default) do
irb:> 	# PerformSomeComplexOperation
irb:> end # memoizes(until the end of the day) and returns the result of #PerformSomeComplexOperation
irb:> p result.inspect
```

The default API that the gem provides is: `MemoizeUntil#min, MemoizeUntil#hour, MemoizeUntil#day, MemoizeUntil#week, MemoizeUntil#month` with `default` purposes(keys). 

To add new purposes during run_time, you can also leverage the `add_to` API:
```ruby
irb:> MemoizeUntil.add_to(:day, :runtime_key) 
irb:> result = MemoizeUntil.day(:runtime_key) do
irb:> 	# PerformSomeComplexRuntimeOperation
irb:> end # memoizes(until the end of the day) and returns the result of #PerformSomeComplexOperation
irb:> p result.inspect
```
The same can be done for other default kinds as well: `min, hour, week, month`

## Rails

To use this gem in a rails application, add the following line to your `Gemfile` and you are good to go.

```ruby
gem 'memoize_until'
```

For most use cases, the list of purposes that come will not suffice. You can define your custom list of config purposes that you wish to memoize for, by including a `config/memoize_until.yml` in the root directory of your application. Here is an [example](/examples/memoize_until.yml) to help you with the file structure. 

## Testing
To run test cases,
```shell
bundle install
ruby -Ilib:test test/memoize_until_test.rb
```

This project is Licensed under the MIT License. Further details can be found [here](/LICENSE).
