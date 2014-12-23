# Product Class
require './modules/jsonable.rb'
require './modules/object_file_handler.rb'
require './modules/display_db_content.rb'
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
