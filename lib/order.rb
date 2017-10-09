require_relative './sms'

class Order

  attr_accessor :basket, :order_id, :name

  ORDER_ID = 7357

  def initialize(order_id = ORDER_ID)
    @basket = []
    @order_id = order_id
    @name = name
    @order = ''
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

  def view
  end

  def confirm_order
    text = SMS.new
    text.send_sms(@order_id, @name, sum_basket, print_order)
  end

  def customer_details
    puts 'Please enter your name:'
    @name = gets.chomp
  end

  def print_order
    @basket.each { |dish| @order << "#{dish[2]}x #{dish[0]}, "}
    @order
  end
end
