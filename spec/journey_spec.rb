require 'journey'

describe Journey do

  let(:station) { double :station, :name => "bank", :zone => 1 }

  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:exit_station) }

  it 'should have an empty list of journeys by default' do
    expect(subject.journey_history).to eq []
  end

  it 'should add entry and exit stations to journey history as one journey' do
    subject.enter(station)
    subject.leave(station)
    expect(subject.journey_history).to include({"entry_station" => station, "exit_station" => station  })
  end

  it { is_expected.to respond_to(:complete?) }

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'should deduct penalty fare on double touch_in' do
    subject.enter(station)
    subject.enter(station)
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'should deduct penalty fare on double touch_out' do
    subject.leave(station)
    subject.leave(station)
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end
