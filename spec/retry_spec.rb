require 'rspec/retry/alt'

describe 'retry' do
  include RSpec::Retry::Alt

  around do |example|
    rerun example, 20
  end

  it 'works' do
    expect(rand(10)).to eq 0
  end
end
