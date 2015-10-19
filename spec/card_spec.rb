require 'Card'

describe Card do

  it 'responds to money' do
    expect(subject).to respond_to :money
  end

end
