require 'station'
describe Station do

  it 'has a name and a zone' do
    station = Station.new("euston", 1)
    expect(station).to have_attributes(:name => "euston", :zone => 1)
  end

end
