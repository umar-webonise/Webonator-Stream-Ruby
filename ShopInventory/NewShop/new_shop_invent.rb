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
end

# To create Product Object
# Attributes of Product name price stock company & id
class Product
  include JSONable
  include ObjectFileHandler
  DB_PATH = 'database/inventory.txt'
  ID_PATH = 'database/inventory_id.txt'
  attr_writer :id
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
  DB_PATH = 'database/order.txt'
  ID_PATH = 'database/order_id.txt'
  attr_writer :id
  def initialize(args = {})
    args.each do |instance_var, instance_val|
      instance_variable_set("@#{instance_var}", instance_val)
    end
  end
end

class User; end

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
