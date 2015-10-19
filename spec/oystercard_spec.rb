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

  it 'deducts money from balance' do
    subject.top_up(20)
    expect{subject.deduct 10}.to change {subject.balance}.by -10
  end

  it 'expect to respond to touch in' do
    expect(subject).to respond_to(:touch_in)
  end

  it 'expect to respond to touch out' do
    expect(subject).to respond_to(:touch_out)
  end

  it "is not in journey if not used" do
    expect(subject).not_to be_in_journey
  end

  it "expect touch_in to change the value of jorney" do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "expect touch_out to change the value of journey in false" do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
