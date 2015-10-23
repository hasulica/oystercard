class JourneyLog

  attr_reader :journeys, :journey

  def initialize(journey_klass: Journey)
    @journeys = []
    @journey_klass = journey_klass
  end

  def start_journey(station)
    current_journey = journey_klass.new(station)
    @journeys << current_journey
  end

  private

  attr_reader :journey_klass

end
