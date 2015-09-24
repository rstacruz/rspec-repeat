require 'rspec/retry/alt'

describe 'retry' do
  include RSpec::Retry::Alt

  around do |example|
    rerun example, 3
  end

  it 'works' do
    expect(rand(2)).to eq 0
  end
end
