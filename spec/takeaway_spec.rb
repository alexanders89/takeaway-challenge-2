require './lib/takeaway'

describe Takeaway do

  subject(:takeaway) {described_class.new}


  it 'has a menu' do
    takeaway = Takeaway.new
    expect(takeaway).to respond_to :menu
  end

  it 'menu contains items and prices' do
    takeaway = Takeaway.new
    expect(takeaway.view_menu).to eq('Chicken: £4, Beef: £3, Quail: £8')
  end
end
