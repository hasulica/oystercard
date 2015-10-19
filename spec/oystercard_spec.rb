require 'oystercard'

describe Oystercard do

  it {is_expected.to respond_to(:balance)}

  it 'has a default value of 0' do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  it 'adds money to balance' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it "raise an error if the new balance is more than #{Oystercard::MAX_BALANCE}" do
    subject.top_up Oystercard::MAX_BALANCE
    expect{subject.top_up(1)}.to raise_error "the limit is #{Oystercard::MAX_BALANCE}"
  end

end
