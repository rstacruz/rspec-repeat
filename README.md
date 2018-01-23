# RSpec::Repeat

> Repeats an RSpec example until it succeeds

```rb
# spec_helper.rb

# Example: Repeat all tests in CI
if ENV['CI']
  require 'rspec/repeat'

  RSpec.configure do
    config.include RSpec::Repeat
    config.around :each do
      repeat example, 3.times, verbose: true
    end
  end
end
```
[![Status](https://travis-ci.org/rstacruz/rspec-repeat.svg?branch=master)](https://travis-ci.org/rstacruz/rspec-repeat "See test builds")

<br>

## Advanced usage

### Options

```
repeat example, 3.times, { options }
```

You can pass an `options` hash:

- __clear_let__ *(Boolean)* — if *false*, `let` declarations will not be cleared.
- __exceptions__ *(Array)* — if given, it will only retry exception classes from this list.
- __wait__ *(Numeric)* — seconds to wait between each retry.
- __verbose__ *(Boolean)* — if *true*, it will print messages upon failure.

### Attaching to tags

This will allow you to repeat any example multiple times by tagging it.

```rb
# rails_helper.rb or spec_helper.rb
require 'rspec/repeat'

RSpec.configure do
  config.include RSpec::Repeat
  config.around :each, :stubborn do |example|
    repeat example, 3.times
  end
end
```

```rb
describe 'stubborn tests', :stubborn do
  # ...
end
```

### Attaching to features

This will make all `spec/features/` retry thrice. Perfect for Poltergeist/Selenium tests that intermittently fail for no reason.

```rb
# rails_helper.rb or spec_helper.rb
require 'rspec/repeat'

RSpec.configure do
  config.include RSpec::Repeat
  config.around :each, type: :feature do
    repeat example, 3.times
  end
end
```

In these cases, it'd be smart to restrict which exceptions to be retried.

```rb
repeat example, 3.times, verbose: true, exceptions: [
  Net::ReadTimeout,
  Selenium::WebDriver::Error::WebDriverError
]
```

### Repeating a specific test

You can also include RSpec::Repeat in just a single test block.

```rb
require 'rspec/repeat'

describe 'a stubborn test' do
  include RSpec::Repeat

  around do |example|
    repeat example, 10.times
  end

  it 'works, eventually' do
    expect(rand(2)).to eq 0
  end
end
```

<br>

## Acknowledgement

Much of this code has been refactored out of [rspec-retry](https://github.com/NoRedInk/rspec-retry) by [@NoRedInk](https://github.com/NoRedInk).

<br>

## Thanks

**rspec-repeat** © 2015-2017, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored and maintained by Rico Sta. Cruz with help from contributors ([list][contributors]).

> [ricostacruz.com](http://ricostacruz.com) &nbsp;&middot;&nbsp;
> GitHub [@rstacruz](https://github.com/rstacruz) &nbsp;&middot;&nbsp;
> Twitter [@rstacruz](https://twitter.com/rstacruz)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/rspec-repeat/contributors
