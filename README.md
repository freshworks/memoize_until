# MemoizeUntil

This gem is an extension to the standard **memoization pattern**.

Use cases that this solves are as follows:

* Fixed interval memoization of complex operations
* Consistent local memoization pattern across multiple processes/instances
* Memoization of app configurations stored in datastores like Redis, mysql, etc. that are not required to be real-time
* Memoization of 3rd party configurations or responses that are not required to be real-time

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

The default API that the gem provides is: `MemoizeUntil#min, MemoizeUntil#hour, MemoizeUntil#day, MemoizeUntil#week, MemoizeUntil#month` with `default` key.

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