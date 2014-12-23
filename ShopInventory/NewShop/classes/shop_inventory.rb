# Shop Inventory Class
require './classes/customer.rb'
require './classes/shop_keeper.rb'
# Main Class for Shop Inventory Application
class ShopInventory
  def menu
    puts 'Please Mention What type of User You Are by Entering Number:'
    puts "1::Customer \n2::Shop Keeper"
    choice = gets.to_i
    case choice
    when 1
      Customer.new.menu
    when 2
      ShopKeeper.new.menu
    else
      puts 'Invalid Input'
    end
  end
end
