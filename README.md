# MustBeOrdered

[![Build Status](https://travis-ci.org/pi-chan/must_be_ordered.svg?branch=master)](https://travis-ci.org/pi-chan/must_be_ordered)

`must_be_ordered` gem is to warn or raise error if `order` is not set to ActiveRecord's Relation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'must_be_ordered'
```

And then execute:

    $ bundle


## Usage

Configuration:

```ruby
# config/initializers/must_be_ordered.rb
MustBeOrdered.enabled = !Rails.env.production?

# choose action you need
MustBeOrdered.raise = true
MustBeOrdered.must_be_ordered_logger = true
MustBeOrdered.rails_logger = true
```

Models:

```ruby
class Item < ActoveRecord::Base
  must_be_ordered
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pi-chan/must_be_ordered.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
