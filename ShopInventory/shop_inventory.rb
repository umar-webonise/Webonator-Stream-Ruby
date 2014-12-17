class Product

	def self.set_id
		id_file = File.open("database/id.txt", "r")
		id = id_file.read
		id_file.close
		@@product_count = id.to_i
	end

	def self.store_id
		id_file = File.open("database/id.txt", "w")
		id_file.write(@@product_count)
		id_file.close
	end

	def initialize (name, price, stock, company)
		@name = name
		@price = price
		@stock = stock
		@company = company
		Product.set_id
		@id = @@product_count
		@@product_count = @@product_count + 1
	end

	attr_accessor :name, :price, :stock, :company

	def write_product 
		inventory_file = File.new("database/inventory.txt", "a")
		inventory_file.puts "#{@id} #{@name} #{@company} #{@price} #{@stock}"
		inventory_file.close
		Product.store_id
	end

end#-----Product

module GeneralInventoryOperations

	def list_products
		puts "---------------------------------"
		puts ":id :name :company :price :stock "
		puts "---------------------------------"
		puts File.open("database/inventory.txt", "r") {|file| contents = file.read}
	end

	def search_product
		print "Enter NAME of Product : "
		name=gets.chomp
		contents = File.open("database/inventory.txt", "r") {|file| contents = file.read}
		match_product = /\d+\s#{name}\s[a-zA-Z]+\s\d+\s\d+/i.match(contents)
		if match_product == nil
			puts "Product Does not Exist in this Store"
		else
			puts "---------------------------------"
			puts ":id :name :company :price :stock "
			puts "---------------------------------"
			puts match_product
		end
	end
end


class ShopUser; end

class ShopKeeper < ShopUser
	include GeneralInventoryOperations

	def self.menu(shop_keeper_object)
		
		puts "Welcome to Webonise Mega Mart have a Nice Day Here"
		loop do
			puts "Please Select any follow options by Entering number:"
			puts "1:Search for a Product\n2:View List of Products\n3:Add Product\n4:Edit Product Details\n5:Remove Product"
			choice = gets.to_i
			case choice
			when 1
				shop_keeper_object.search_product
			when 2
				shop_keeper_object.list_products
			when 3
				shop_keeper_object.add_product
			when 4
				shop_keeper_object.edit_product
			when 5
				shop_keeper_object.remove_product
			else
				puts "Invalid Input"					
			end
			puts "Do you want to continue y/n?"
			continue_choice = gets.chomp.to_s

			break if continue_choice == "n" or continue_choice == "N"
		end
	end

	def add_product
		puts "Enter Product Name:"
		name = gets.chomp
		puts "Enter Product Price:"
		price = gets.chomp.to_i
		puts "Enter Number of Stock items:"
		stock = gets.chomp.to_i
		puts "Enter Product Company:"
		company = gets.chomp

		product = Product.new(name, price, stock, company)
		product.write_product
	end

	def remove_product
		puts "Enter ID of Product to REMOVE :"
		product_id = gets.chomp.to_i

		
		contents = File.open("database/inventory.txt", "r") {|file| contents = file.read}
		new_contents = contents.gsub(/#{product_id}\s[a-zA-Z]+\s[a-zA-Z]+\s\d+\s\d+\n/m, "")
		File.open("database/inventory.txt", "w") {|file| file.puts new_contents }
	end

	def edit_product
		puts "Enter ID of Product to EDIT :"
		product_id = gets.chomp.to_i
		puts "Enter Product Name:"
		name = gets.chomp
		puts "Enter Product Price:"
		price = gets.chomp.to_i
		puts "Enter Number of Stock items:"
		stock = gets.chomp.to_i
		puts "Enter Product Company:"
		company = gets.chomp

		contents = File.open("database/inventory.txt", "r") {|file| contents = file.read}
		new_contents = contents.gsub(/#{product_id}\s[a-zA-Z]+\s[a-zA-Z]+\s\d+\s\d+\n/m, "#{product_id} #{name} #{company} #{price} #{stock}\n")
		File.open("database/inventory.txt", "w") {|file| file.puts new_contents }
	end

	

end

class Customer < ShopUser
	include GeneralInventoryOperations

	def self.menu(customer_object)
		

		puts "Welcome to Webonise Mega Mart"
		loop do
			puts "Please Select any follow options by Entering number:"
			puts "1:Search for a Product\n2:View List of Products\n3:Buy Product"
			choice = gets.to_i					
				case choice
				when 1
					customer_object.search_product
				when 2
					customer_object.list_products
				when 3
					customer_object.buy_product
				else
					puts "Invalid Input"					
				end
			puts "Do you want to continue y/n?"
			continue_choice = gets.chomp.to_s
			break if continue_choice == "n" or continue_choice == "N"
		end

	end

	def buy_product
		puts "Enter ID of Product to Buy :"
		product_id = gets.chomp.to_i

		contents = File.open("database/inventory.txt", "r") {|file| contents = file.read}
		match_product = /#{product_id}\s[a-zA-Z]+\s[a-zA-Z]+\s\d+\s\d+/.match(contents)
		match_product = match_product.to_s.scan(/\w+/)
		stock = match_product[4].to_i

		if (stock > 0)
			puts "Enter Transaction Detail"
			stock = stock - 1
			puts "Enter Your Name :"
			cust_name = gets.chomp
			puts "Enter Card Number :"
			card_number = gets.chomp.to_i
			puts "Enter CVV code :"
			cvv =gets.chomp.to_i
			
			File.open("database/order.txt", "a") {|file| file.write("#{cust_name} #{card_number} #{cvv}\n")}
			contents = File.open("database/inventory.txt", "r") {|file| contents = file.read}
			new_contents = contents.gsub(/#{product_id}\s[a-zA-Z]+\s[a-zA-Z]+\s\d+\s\d+\n/m, "#{product_id} #{match_product[1]} #{match_product[2]} #{match_product[3]} #{stock}\n")
			File.open("database/inventory.txt", "w") {|file| file.puts new_contents }
			puts "Transaction Complete"
		else
			puts "Product Out of Stock, Sorry for the inconvenience"
		end

	end
end

#---Main Program

puts "Please Mention What type of User You Are by Entering Number:\n1::Customer \n2::Shop Keeper"

choice = gets.to_i

case choice
when 1
	customer = Customer.new
	Customer.menu(customer)
when 2
	shop_keeper = ShopKeeper.new
	ShopKeeper.menu(shop_keeper)
else
	puts "Invalid Input"
end

#shop_keeper.add_product

#shop_keeper.remove_product

#shop_keeper.edit_product

#shop_keeper.list_products

#shop_keeper.search_product

#customer.buy_product

#customer.list_products

#customer.search_product

#puts "No Erros"