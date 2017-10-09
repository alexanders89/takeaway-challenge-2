require './lib/takeaway'

describe Takeaway do

  subject(:takeaway) {described_class.new}


  it 'has a menu' do
    expect(takeaway).to respond_to :menu
  end

  it 'menu contains items and prices' do
    expect(takeaway.view_menu).to eq('Chicken: £4, Beef: £3, Quail: £8')
  end

  it 'can create an order' do
    expect{ takeaway.create_order }.not_to raise_error

  end
end
