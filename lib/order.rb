class Order

  attr_accessor :basket

  def initialize
    @basket = []
  end

  def add(item, price, quantity)
    total = price * quantity
    @basket << [item, price, quantity, total]
  end

  def sum_basket
    value = []
    @basket.each { |dish| value << dish[3] }
    value.sum
  end
end
