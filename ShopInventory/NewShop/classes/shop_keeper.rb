require './classes/product.rb'
require './classes/order.rb'
require './classes/user.rb'

# Shopkeeper is a User Add, Remove, List,Edit & Search products
class ShopKeeper < User
  def menu
    puts 'Welcome to Webonise Mega Lab Mart have a Nice Day Here'
    loop do
      puts 'Please Select any follow options by Entering number:'
      puts "1:Search for a Product\n2:View List of Products\n3:Add Product"
      puts "4:Edit Product Details\n5:Remove Product\nYour Choice?"
      choice = gets.to_i
      option = {
        1 => method(:search_product),
        2 => method(:display_products),
        3 => method(:add_product),
        4 => method(:edit_product),
        5 => method(:remove_product)
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

  def add_product
    puts 'Enter Product Name:'
    name = gets.chomp
    puts 'Enter Product Price:'
    price = gets.chomp.to_i
    puts 'Enter Number of Stock items:'
    stock = gets.chomp.to_i
    puts 'Enter Product Company:'
    company = gets.chomp
    input_hash = { name: name, price: price, stock: stock, company: company }
    product = Product.new(input_hash)
    product.set_id
    product.save
  end

  def remove_product
    puts 'Enter ID of Product to REMOVE :'
    id = gets.chomp.to_i
    product_obj = Product.new
    product_obj.search_object!(:id, id)
    product_obj.remove_object
  end

  def edit_product
    puts 'Enter ID of Product to EDIT :'
    id = gets.chomp.to_i
    puts 'Enter Product Name:'
    name = gets.chomp
    puts 'Enter Product Price:'
    price = gets.chomp.to_i
    puts 'Enter Number of Stock items:'
    stock = gets.chomp.to_i
    puts 'Enter Product Company:'
    company = gets.chomp
    product_obj = Product.new
    product_obj.search_object!(:id, id)
    hash = { name: name, price: price, stock: stock, company: company }
    product_obj.update_object(hash)
  end
end
