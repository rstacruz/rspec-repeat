require 'rspec/repeat'

shared_context 'my context' do
  let(:number) { rand(10) }
end

describe 'context' do
  include RSpec::Repeat

  around do |example|
    repeat example, 100.times
  end

  include_context 'my context'

  it 'works' do
    expect(number).to eq 0
  end
end
