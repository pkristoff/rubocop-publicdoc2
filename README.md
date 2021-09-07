# Rubocop::Publicdoc2

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rubocop/publicdoc2`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-publicdoc2', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop-publicdoc2

## Usage

TODO: Write usage instructions here

## Development

- Check out the repo, 
- run `bin/setup` to install dependencies. Then, 
- run `rake spec` to run the tests. 
- You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To release a new version, 
- update the version number in `version.rb`,
- update CHANGELOG.md
- push (commit) changes
- then run `bundle exec rake release`, 
    - which will create a git tag for the version, 
    - push git commits and tags, and 
    - push the `.gem` file to [rubygems.org](https://rubygems.org).

if gem does not push then run 
- gem push pkg/rubocop-publicdoc2-<new version>.gem

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubocop::Publicdoc2 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rubocop-publicdoc2/blob/master/CODE_OF_CONDUCT.md).
