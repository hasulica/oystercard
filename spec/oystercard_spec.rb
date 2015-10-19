require 'oystercard'

describe Oystercard do

  it {is_expected.to respond_to(:balance)}

  it 'has a default value of 0' do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  it 'adds money to balance' do
    initial_balance = subject.balance
    subject.top_up(20)
    expect(subject.balance).to eq initial_balance + 20
  end

end
