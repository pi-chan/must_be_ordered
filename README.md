# MustBeOrdered

[![Build Status](https://travis-ci.org/pi-chan/must_be_ordered.svg?branch=master)](https://travis-ci.org/pi-chan/must_be_ordered)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/must_be_ordered`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'must_be_ordered'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install must_be_ordered

## Usage

TODO: Write usage instructions here

## Configuration

MustBeOrdered won't do ANYTHING unless you tell it to explicitly. Append to
`config/environments/development.rb` initializer with the following code:

```ruby
config.after_initialize do
  MustBeOrdered.enabled = true
  MustBeOrdered.sentry = true
  MustBeOrdered.must_be_ordered_logger = true
  MustBeOrdered.xmpp = { :account  => 'bullets_account@jabber.org',
                  :password => 'bullets_password_for_jabber',
                  :receiver => 'your_account@jabber.org',
                  :show_online_status => true }
  MustBeOrdered.rails_logger = true
  MustBeOrdered.honeybadger = true
  MustBeOrdered.bugsnag = true
  MustBeOrdered.airbrake = true
  MustBeOrdered.rollbar = true
  MustBeOrdered.slack = { webhook_url: 'http://some.slack.url', channel: '#default', username: 'notifier' }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xoyip/must_be_ordered.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
