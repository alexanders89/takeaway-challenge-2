class Takeaway

  attr_accessor :menu

  def initialize
    @menu = []
  end

  def view_menu
    'Chicken: £4, Beef: £3, Quail: £8'
  end
end
