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
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "expect touch_out to change the value of journey to false" do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'should not allow touch it with less than £1 balance' do
    expect{subject.touch_in}.to raise_error "Minimum balance is £#{Oystercard::MIN_BALANCE}"
  end

  it 'should reduce balance on touch out by MIN_FARE' do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in
    expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_FARE
  end

end
