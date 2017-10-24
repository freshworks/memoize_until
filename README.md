# MemoizeUntil

This gem is an extension to the standard **memoization pattern**.

Use cases that this solves are as follows:

* Memoization of configurations stored in Redis/DB that do not change frequently.
* Memoization of 3rd party configurations or results that do not change frequently.

Usage:

```ruby
gem install memoize_until
> irb
irb:> require 'memoize_until'
irb:> MemoizeUntil.day(:default) {
irb:> 	PerformSomeComplexOperation
irb:> }
irb:> # memoizes and returns the result of #PerformSomeComplexOperation
```

The default keys that come with the gem are: 

1. day
	1. default
1. hour
	1. default
1. min
	1. default
1. week
	1. default
1. month
	1. default

The higher level keys denote the duration until which you wish to memoize the result. For eg.) `MemoizeUntil.day` will memoize the results until the end of the current day. Similarly other top-level keys act as the `API` for `MemoizeUntil` class.

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
and add the following line anywhere in your application like `application.rb, config/initializers/memoize_until.rb, etc.`:
```ruby
require 'memoize_until'
```
The caveat here is, memoize_until should be required only after Rails has been initialised. 

To run test cases,
```ruby
ruby -Ilib:test test/test_memoize_until.rb
```

This project is Licensed under the MIT License. Further details can be found [here](/LICENSE).