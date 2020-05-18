# Cocoapods::Env

This [CocoaPods plugin](https://guides.cocoapods.org/plugins/index.html) adds the ability to set user defined parameters during pod installation and access them in your Podfile. Parameters are passed in the format `user-defined-${parameter_name}=${value}`, and can be accessed via the `user_defined_options` hash in the `Podfile`.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'cocoapods-env', git: 'git@github.vimeows.com:MobileApps/cocoapods-env.git', branch: 'master'
```

And then execute:

```bash
bundle install
```

Add the plugin to your `Podfile`

```ruby
plugin 'cocoapods-env'
```

## Usage

Example usage:

```ruby
# podfile.rb
plugin 'cocoapods-env'
workspace 'Vimeo'

target_platform = user_defined_options[:platform] || "ios"
deployment_target = user_defined_options[:deployment_target] || 12.4
platform target_platform, deployment_target

pod 'ExamplePod'
```

Then you can customize the platform and deployment target via user-defined parameters:

```bash
bundle exec pod install --user-defined-platform=ios --user-defined-deployment_target=12.4
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
