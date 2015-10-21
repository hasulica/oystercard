class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :journey_history, :exit_station, :entry_station

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def enter(station)
    @entry_station = station
    journey_history
  end

  def leave(station)
    @exit_station = station
    trip
  end

  def fare
    if !complete?
         PENALTY_FARE
    else
         MIN_FARE
    end
  end

  def complete?
    return false if exit_station == nil || entry_station == nil
    true
  end

private

  def trip
    journey_history << {entry_station => exit_station}
    @entry_station = nil
    @exit_station = nil
  end
end
