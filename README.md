# Spectre ruby client

A gem to upload screenshots to [Spectre](https://github.com/wearefriday/spectre).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spectre_client', git: 'git@github.com:wearefriday/spectre_client.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spectre_client

## Usage

There are two steps to submitting a test to Spectre: first create a "run" that is associated to a "project" (a category) and a "suite" (a sub-category), then submit multiple "tests" (screenshots) to the run.

A run will be created for you when creating a new instance of a `SpectreClient::Client`. Submitting a test with this client object will associate the test with the run.

Create a client object:

    client = SpectreClient::Client.new('Project Name', 'Suite Name', "http://spectre.local")

Submit a test:

  client.submit_test(options_hash)

The method accepts a hash with the following keys:

* `name` (required) — name of your test e.g. "Homepage"
* `browser` (required) — the user agent you used to create your screenshot e.g. "Chrome", "Safari, iOS 7" or "phantomjs" etc.
* `size` (required) — screenshot size, generally its width, but whatever makes sense for you e.g. "1200px", "medium" or "tablet" etc.
* `screenshot` (required) — a reference to a `File`
* `source_url` (optional) — the URL of the page you've taken a screenshot of, Spectre will link tests to this URL for convenience
* `fuzz_level` (optional) — how forgiving should the comparison be, as a percentage, to allow for slight variations in browser sub-pixel rendering/antialiasing. Defaults to `30%` (a lower number means less forgiving)
* `highlight_colour` (optional) — the colour used in the diff images. Defaults to `red`. (See ImageMagick's [`highlight-color`](http://www.imagemagick.org/script/command-line-options.php#highlight-color))

Example:

  client.submit_test({
    name: 'Homepage',
    browser: 'Firefox',
    size: '1200',
    screenshot: File.new('homepage.png', 'rb'),
    source_url: 'http://mysite.dev/'
  })

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/wearefriday/spectre_client>.

## Licence

The gem is available as open source under the terms of the [MIT Licence](http://opensource.org/licenses/MIT).
