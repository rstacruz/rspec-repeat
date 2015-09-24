# Rspec::Retry::Alt

```rb
describe 'a stubborn test' do
  include Rspec::Retry::Alt
  
  around do |example|
    retry example, 3
  end

  it 'works' do
    expect(rand(2)).to eq 0
  end
end
```
