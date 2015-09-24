require 'rspec/repeat'

describe 'retry' do
  include RSpec::Repeat

  around do |example|
    repeat example, 100.times
  end

  it 'works' do
    expect(rand(10)).to eq 0
  end
end
