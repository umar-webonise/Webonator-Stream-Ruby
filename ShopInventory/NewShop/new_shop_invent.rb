# Program to manage Shop Inventory
require 'json'
# To convert a Object into json format
module JSONable
  def to_json
    hash = {}
    instance_variables.each do |var|
      hash[var] = instance_variable_get(var)
    end
    hash.to_json
  end

  def from_json!(string)
    JSON.load(string).each do |var, val|
      instance_variable_set(var, val)
    end
  end
end

# to manage all the file operations required for file data base
module ObjectFileHandler
  def save
    File.open(self.class::DB_PATH, 'a+') { |file| file.puts to_json }
  end

  def set_id
    id = File.open(self.class::ID_PATH, 'r') { |file| file.read }
    self.id = id.to_i + 1
    File.open(self.class::ID_PATH, 'w') { |file| file.write(@id) }
  end

  def search_object!(id)
    match_data = File.readlines(self.class::DB_PATH).find do |line|
      line.match(/.*"@id":#{id}\}/)
    end
    return false if match_data.to_s.empty?
    from_json!(match_data.to_s)
  end

  def remove_object
    contents = File.open(self.class::DB_PATH, 'r') { |file| file.read }
    contents = contents.gsub(/.*"@id":#{@id}\}\n/m, '')
    File.open(self.class::DB_PATH, 'w') { |file| file.puts contents }
  end

  def update_object(args = {})
    args.each do |instance_var, instance_val|
      instance_variable_set("@#{instance_var}", instance_val)
    end
    contents = File.open(self.class::DB_PATH, 'r') { |file| file.read }
    contents = contents.gsub(/.*"@id":#{@id}\}/, to_json)
    File.open(self.class::DB_PATH, 'w') { |file| file.puts contents }
  end

  def to_s_object
    object_string = "#{self.class}:: "
    instance_variables.each do |var|
      object_string = "#{object_string}#{instance_variable_get(var)}: "
    end
    object_string
  end
end

# Display contents of DB
module DisplayDBContent
  def display
    product_obj = new
    File.readlines(self::DB_PATH).each do |lines|
      product_obj.from_json!(lines)
      puts product_obj.to_s_object
    end
  end
end

# To create Product Object
# Attributes of Product name price stock company & id
class Product
  include JSONable
  include ObjectFileHandler
  extend DisplayDBContent
  DB_PATH = 'database/inventory.txt'
  ID_PATH = 'database/inventory_id.txt'
  attr_accessor :id, :stock
  def initialize(args = {})
    args.each do |instance_var, instance_val|
      instance_variable_set("@#{instance_var}", instance_val)
    end
  end
end

# To create Order Objects
# Attributes of Product customer name ,product id, card number, cvv number & id
class Order
  include JSONable
  include ObjectFileHandler
  extend DisplayDBContent
  DB_PATH = 'database/order.txt'
  ID_PATH = 'database/order_id.txt'
  attr_accessor :id
  def initialize(args = {})
    args.each do |instance_var, instance_val|
      instance_variable_set("@#{instance_var}", instance_val)
    end
  end
end

class User; end

# Shopkeeper is a User Add, Remove, List,Edit & Search products
class ShopKeeper < User
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
    product_obj.search_object!(id)
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
    product_obj.search_object!(id)
    hash = { name: name, price: price, stock: stock, company: company }
    product_obj.update_object(hash)
  end

  def display_products
    Product.display
  end
end

# Customer is a User who can  List, Buy & Search products
class Customer < User
  def buy_product
    puts 'Enter ID of Product to Buy :'
    id = gets.chomp.to_i
    product = Product.new
    exist_flag = product.search_object!(id)

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
        hash = { c_name: c_name, p_id: id, card_no: card, cvv: cvv, id: 0 }
        order = Order.new(hash)
        order.set_id
        order.save
      else
        puts 'Product Out of stock'
      end
    else
      puts 'Product Not Found'
    end
  end

  def display_products
    Product.display
  end
end

# Code to buy product
customer = Customer.new
customer.buy_product

# Code to add products to DB
# shopkeeper = ShopKeeper.new
# shopkeeper.add_product

# Code to list DataBase contents
# Product.display

# Code to display Object
# product_obj = Product.new
# product_obj.search_object!(2)
# puts product_obj.to_s_object

# Code to update Product details return object
# product_obj = Product.new
# product_obj.search_object!(2)
# product_obj.update_object(name: 'Meat')

# Code to remove Product and return object
# product_obj = Product.new
# product_obj.search_object!(1)
# product_obj.remove_object

# Code to search Product and return an object
# product_obj = Product.new
# product_obj.search_object!(1)
# puts product_obj.inspect

# Code for Adding Data
# args = { name: 'Bla Bla', price: 100, stock: 5, company: 'ZZZZ', id: 0 }
# product_obj = Product.new(args)
# product_obj.set_id
# product_obj.save

# str = product_obj.to_json
# product_obj1 = Product.new
# product_obj1.from_json!(str)
# puts product_obj1.inspect
# args = {:product_id=>0, :cust_name=>10, :card_no=>3, :cvv_no=>"XXXX", :id=>0}
