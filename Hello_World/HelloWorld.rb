3.times {|n| puts "Hello World" }


class Product
	def initialize name = "umar", age = 22
		@name = name
		@age = age
	end
	attr_accessor :name, :age
end

arr = [Product.new, Product.new("qasim", 18)]

user = arr.find {|a| a.name = "qasim"}

