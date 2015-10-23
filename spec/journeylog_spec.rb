require "journeylog"

describe JourneyLog do

  let(:journey) {double :journey, :new => :journey}
  let(:station) {double :station}
  let(:journey_klass) { double :journey_klass, new: journey }
  subject {described_class.new(journey_klass: journey_klass)}

  describe '#start_journey' do

    it 'starts a journey' do
      expect(journey_klass).to receive(:new).with(:station)
      subject.start_journey(:station)
    end

    it 'should add journey to log' do
      allow(journey_klass).to receive(:new).and_return journey
      subject.start_journey(station)
      expect(subject.journeys).to include journey
    end

  end

end
