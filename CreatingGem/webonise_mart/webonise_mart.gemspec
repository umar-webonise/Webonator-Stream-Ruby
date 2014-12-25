require './lib/webonise_mart/version'
Gem::Specification.new do |s|
  s.name        = 'webonise_mart'
  s.version     = WeboniseMart::VERSION
  s.date        = '2014-12-25'
  s.summary     = "Shop invnetory management system"
  s.description = "Simple implementation of inventory management with tow types of users"
  s.authors     = ["Umar Siddiqui"]
  s.email       = 'umar.s@weboniselab.com'
  s.files       = ["lib/webonise_mart.rb",
    "lib/classes/shop_inventory.rb",
    "lib/classes/customer.rb",
    "lib/classes/shop_keeper.rb",
    "lib/classes/product.rb",
    "lib/classes/order.rb",
    "lib/classes/user.rb",
    "lib/modules/display_db_content.rb",
    "lib/modules/jsonable.rb",
    "lib/modules/object_file_handler.rb"
  ]
  s.require_paths =["lib"]
  s.homepage    =
    'http://rubygems.org/gems/hola'
  s.license       = 'Webonise'
end