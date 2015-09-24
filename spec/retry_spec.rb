require 'rspec/repeat'

describe 'retry' do
  include RSpec::Repeat
  describe 'normal case' do
    around do |example|
      repeat example, 100.times
    end

    it 'works' do
      expect(rand(10)).to eq 0
    end
  end

  describe 'clearing let' do
    around do |example|
      repeat example, 100.times
    end

    let(:number) { rand(10) }

    it 'works' do
      expect(number).to eq 0
    end
  end

  describe 'exceptions list' do
    FooError = Class.new(StandardError)

    around do |example|
      repeat example, 100.times, exceptions: [FooError]
    end

    it 'works' do
      raise FooError if rand(10) != 0
    end
  end
end
