require 'oystercard'

describe Oystercard do
  it {is_expected.to respond_to(:balance)}
  it 'has a default value of 0' do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end
end
