# This code is not tested and is purely for my own amusement




require 'terminal-table'
require 'colorize'
require 'rubygems'
require 'twilio-ruby'



@students = []
@basket = []

def interactive_menu
  header
  loop do
    puts "===================="
    puts "1. Add Menu"
    puts "2. Show Menu"
    puts "3. Delete Entry"
    puts "4. Edit Entry"
    puts "5. Save Menu"
    puts "6. Load Menu"
    puts "7. Order Food"
    puts "8. View Basket"
    puts "9. Send Order"
    puts "10. Display Order"
    puts "11. Exit"
    puts "===================="
    selection = gets.chomp
    case selection
    when "1"
      input_dish
    when "2"
      view_all
    when "3"
      delete_entry
    when "4"
      edit_entry
    when "5"
      save_menu
    when "6"
      load_menu
    when "7"
      add_to_basket
    when "8"
      view_basket
    when "9"
      send_order
    when "10"
      display_order
    when "11"
      exit
    end
  end
end

def view_basket
  header
  rows = []
  @basket.each { |dish, quantity, price| rows << [quantity,
  dish, price, price.to_i * quantity.to_i ] }
  table = Terminal::Table.new :headings => ['Qty'.red, 'Dish'.red, 'Price'.red, 'Total'.red],
  :rows => rows
  puts table
  sum_basket
end

def send_order
    account_sid = 'AC85d63b6b199aa2e579f511eaa1f74c44'
    auth_token = '643f6a8a91ec054bb6bc1e8fdca02ac4'
    client = Twilio::REST::Client.new account_sid, auth_token
    puts 'Please enter your name'
    name = gets.chomp
    order_id = 1234
    order = display_order
    total = 0
    @basket.each { |item| total += item[1].to_i * item[2].to_i}
    time = get_time

      client.messages.create(
        from: '+441785472415',
        to: '+447791415382',
        body: "Hi #{name}, Thanks for you order #{order_id} of #{order} totalling £#{total}. Your food will be delivered by #{time}"
      )
end

def get_time
  t = Time.now + (60 * 60 + 10)
  t.to_s[10..15]
end

def display_order
  order = ''
  @basket.each {|dish| order += "#{dish[1]} x #{dish[0]}, "}
  order
end

def sum_basket
  total = 0
  @basket.each { |item| total += item[1].to_i * item[2].to_i}
  puts "£#{total}"
end

def view_all
  header
  rows = []
  @students.each_with_index { |student, value| rows << [value + 1,
  student[:name].capitalize, student[:description].upcase, student[:price].capitalize]}
  table = Terminal::Table.new :headings => ['#'.red, 'Dish'.red, 'Description'.red, 'Price'.red],
  :rows => rows
  puts table
end


def add_to_basket
  header
  view_all
  puts 'Please enter the number dish you would like to order'
  index = gets.chomp
  while !index.empty? do
    puts 'Please enter the quantity'
    quantity = gets.chomp.to_i
    puts "#{quantity} x #{@students[index.to_i - 1][:name]} have been added to your basket"
    @basket << [@students[(index.to_i) -1][:name], quantity, @students[(index.to_i) - 1][:price]]
    puts 'Please enter the number dish you would like to order'
    index = gets.chomp
  end
end

def input_dish
  header
  name = get_name
  while !name.empty? do
    description = get_description
    price = get_price
    @students << {name: name, price: price, description: description}
    puts "Now we have #{@students.count} great student#{'s' if @students.count > 1}"
    name = get_name
      end
end

def edit_entry
  header
  view_all
  puts 'which number would you like to edit?'
  index = gets.chomp.to_i
  new_name = get_name
  new_description = get_description
  new_price = get_price
  @students[index-1].replace({name: new_name,
     price: new_price, description: new_description})
end

def delete_entry
  view_all
  header
  puts 'which number would you like to delete?'
  index = gets.chomp.to_i
  @students.delete_at(index-1)
end

def print_footer(students)
  puts "Overall, we have #{@students.count} great student#{'s' if @students.count > 1}"
end

def save_menu
  puts 'choose a file to save as'
  files = Dir.entries('../menus')
  files.each {|file| puts file[0, file.index('.')]}
  file_to_save = gets.chomp
  file = File.open("../menus/#{file_to_save}.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:description], student[:price]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_menu
  puts 'Choose a menu to view'
  files = Dir.entries('../menus')
  files.each {|file| puts file[0, file.index('.')]}
  file_to_load = gets.chomp
  file = File.open("../menus/#{file_to_load}.csv", "r")
  file.readlines.each do |line|
    name, description, price = line.chomp.split(',')
    @students << {name: name, description:description, price: price}
  end
  file.close
end

def get_name
  header
  puts 'Please enter the name'
  puts 'To exit, hit return twice'
  name = gets.chomp
end

def get_price
  header
  puts 'Please enter price'
  price = gets.chomp
end

def get_description
  header
  puts 'Please enter description'
  description = gets.chomp
end



def view_all
  header
  rows = []
  @students.each_with_index { |student, value| rows << [value + 1,
  student[:name].capitalize, student[:description].upcase, student[:price].capitalize]}
  table = Terminal::Table.new :headings => ['#'.red, 'Dish'.red, 'Description'.red, 'Price'.red],
  :rows => rows
  puts table
end

def view_by_name
  puts "Search by first name"
  letter = gets.chomp
  selected_students = []
  selected_students << @students.select { |student| student[:name][0] == letter }
  selected_students[0].each_with_index { |student, value| puts "#{value + 1}. #{
  student[:name].capitalize} (#{student[:price]} price)"}
end

def header
  puts "\e[H\e[2J"
  puts"
██████╗ ███████╗██╗     ██╗██╗   ██╗███████╗██████╗  ██████╗ ██╗    ██╗██╗
██╔══██╗██╔════╝██║     ██║██║   ██║██╔════╝██╔══██╗██╔═══██╗██║    ██║██║
██║  ██║█████╗  ██║     ██║██║   ██║█████╗  ██████╔╝██║   ██║██║ █╗ ██║██║
██║  ██║██╔══╝  ██║     ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗██║   ██║██║███╗██║██║
██████╔╝███████╗███████╗██║ ╚████╔╝ ███████╗██║  ██║╚██████╔╝╚███╔███╔╝███████╗
╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚══════╝"
end


interactive_menu

#
# print_header
# input_dish
# view_all
# print_footer(@students)
# # # view_by_name
