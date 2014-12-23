# User class
require './classes/product.rb'
# Class representing Users of Shop Inventory
class User
  def display_products
    Product.display
  end

  def search_product
    puts 'Enter Name of Product to search'
    name = gets.chomp
    product = Product.new
    exist_flag = product.search_object!(:name, name)
    if exist_flag
      puts product.to_s_object
    else
      puts 'Product does not exist'
    end
  end
end
