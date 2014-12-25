# Customer class
require 'classes/product'
require 'classes/order'
require 'classes/user'

# Customer is a User who can  List, Buy & Search products
class Customer < User
  def menu
    puts 'Welcome to Webonise Lab Mega Mart'
    loop do
      puts 'Please Select any follow options by Entering number:'
      puts "1:Search for a Product\n2:View List of Products\n3:Buy Product\n"
      puts 'Your Choice?'
      choice = gets.to_i
      option = {
        1 => method(:search_product),
        2 => method(:display_products),
        3 => method(:buy_product)
      }
      instance_eval do
        def default_option
          puts 'Invalid Input'
        end
      end
      option.default = method(:default_option)
      option[choice].call
      puts 'Do you want to continue y/n?'
      continue_choice = gets.chomp.to_s
      break if continue_choice == 'n' || continue_choice == 'N'
    end
  end

  def buy_product
    puts 'Enter ID of Product to Buy :'
    id = gets.chomp.to_i
    product = Product.new
    exist_flag = product.search_object!(:id, id)
    if exist_flag
      stock = product.stock
      if stock > 0
        stock -= 1
        product.update_object(stock: stock)
        puts 'Enter Transaction Detail'
        puts 'Enter Your Name :'
        c_name = gets.chomp
        puts 'Enter Card Number :'
        card = gets.chomp.to_i
        puts 'Enter CVV code :'
        cvv = gets.chomp.to_i
        input = { c_name: c_name, p_id: id, card_no: card, cvv: cvv, id: 0 }
        order = Order.new(input)
        order.set_id
        order.save
      else
        puts 'Product Out of stock'
      end
    else
      puts 'Product Not Found'
    end
  end
end
