require 'oystercard'

describe Oystercard do

  let(:station) { double :station }

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
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it "expect touch_out to change the value of journey to false" do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject).not_to be_in_journey
  end

  it 'should not allow touch it with less than £1 balance' do
    expect{subject.touch_in(station)}.to raise_error "Minimum balance is £#{Oystercard::MIN_BALANCE}"
  end

  it 'should reduce balance on touch out by MIN_FARE' do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in(station)
    expect{ subject.touch_out(station) }.to change{ subject.balance }.by -Oystercard::MIN_FARE
  end

  it 'should remember the entry station where it touches in' do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in(station)
    expect(subject.journey.last["entry_station"]).to eq station
  end

  it 'should remember exit station on touch out' do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.journey.last["exit_station"]).to eq station
  end

  it 'should add latest stations to journey history' do
    subject.top_up Oystercard::MIN_BALANCE
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.journey).to include({"entry_station" => station, "exit_station" => station})
  end

  it 'should have an empty list of journeys by default' do
    expect(subject.journey).to eq []
  end

end
