require './lib/order'

describe Order do
  subject(:order) {described_class.new}

  it 'is initiated with an empty basket' do
    expect(order.basket.count).to eq 0
  end

  it 'can have items added to it' do
    order.add('Chicken', 5, 1)
    expect(order.basket[0]).to eq ['Chicken', 5, 1, 5]
  end

  it 'can add the value of the basket' do
    order.add('Chicken', 5.23, 1)
    order.add('Beef', 4.76, 2)
    expect(order.sum_basket).to eq 14.75
  end
end
