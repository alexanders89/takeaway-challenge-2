require_relative 'order'
require_relative 'sms'
require_relative 'takeaway'

takeaway = Takeaway.new
order = Order.new

puts 'Hi, welcome to the food ordering station'
puts 'Below is the menu'
puts takeaway.view_menu
dish = ''
dishes = []
until dish == 'no' do
  puts 'Please enter the dish you would like to add and the quantity'
  dish = gets.chomp
  dishes << dish if dish != 'no'
end
puts "Thanks, you have chosen #{dishes}"
