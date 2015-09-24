# Rspec::Repeat

Repeats an RSpec example until it succeeds.

```rb
describe 'a stubborn test' do
  include Rspec::Repeat
  
  around do |example|
    repeat example, 3.times
  end

  it 'works' do
    expect(rand(2)).to eq 0
  end
end
```

<br>

### Attaching to tags

```rb
RSpec.configure do
  config.around :each, :foobar do |example|
    repeat example, 3.times
  end
end
```

```rb
describe 'stubborn tests', :foobar do
  # ...
end
```

<br>

## Acknowledgement

Much of this code has been refactored out of [rspec-retry](https://github.com/NoRedInk/rspec-retry) by [@NoRedInk](https://github.com/NoRedInk).

<br>

## Thanks

**rspec-repeat** © 2015+, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored and maintained by Rico Sta. Cruz with help from contributors ([list][contributors]).

> [ricostacruz.com](http://ricostacruz.com) &nbsp;&middot;&nbsp;
> GitHub [@rstacruz](https://github.com/rstacruz) &nbsp;&middot;&nbsp;
> Twitter [@rstacruz](https://twitter.com/rstacruz)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/rspec-repeat/contributors
