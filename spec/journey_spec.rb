require 'journey'

describe Journey do

  it 'has an entry station and exit station' do
    journey = Journey.new
    journey.entry_station = 'bank'
    journey.exit_station = 'euston'
    expect(journey).to have_attributes(:entry_station => 'bank', :exit_station => 'euston')
  end


end
