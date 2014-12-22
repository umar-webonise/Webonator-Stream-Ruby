# Program to manage Shop Inventory
require 'json'

module JSONable
    def to_json
        hash = {}
        self.instance_variables.each do |var|
            hash[var] = self.instance_variable_get var
        end
        hash.to_json
    end
    def from_json! string
        JSON.load(string).each do |var, val|
            self.instance_variable_set var, val
        end
    end
end


module ObjectFileHandler
	def save
		File.open(self.class::DB_PATH, 'a+'){ |file| file.puts self.to_json }
	end

	def set_id
		id = File.open(self.class::ID_PATH, 'r'){ |file| file.read }
		self.id = id.to_i + 1
		File.open(self.class::ID_PATH, 'w'){ |file| file.write(@id) }
	end

  def self.search(id)
    File.readlines(self.class::DB_PATH).each do |line|
      
    end
  end
end

class Product
	include JSONable
	include ObjectFileHandler
	DB_PATH = 'database/inventory.txt'
	ID_PATH = 'database/inventory_id.txt'
	attr_writer :id
	def initialize (args = {})
		args.each do |instance_var, instance_val|
			instance_variable_set("@#{instance_var}",instance_val)
		end
	end
end

class Order
	include JSONable
	include ObjectFileHandler
	DB_PATH = 'database/order.txt'
	ID_PATH = 'database/order_id.txt'
  attr_writer :id
	def initialize args = {}
		args.each do |instance_var, instance_val|
			instance_variable_set("@#{instance_var}",instance_val)
		end
	end
end


args = {:name=>"XXXX", :price=>10, :stock=>3, :company=>"XXXX", :id=>0}
product_obj = Product.new (args)
product_obj.set_id
product_obj.save
#str = product_obj.to_json

#product_obj1 = Product.new

#product_obj1.from_json!(str)
#puts product_obj1.inspect


#args = {:product_id=>0, :cust_name=>10, :card_no=>3, :cvv_no=>"XXXX", :id=>0}


