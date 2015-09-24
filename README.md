# Rspec::Repeat

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
