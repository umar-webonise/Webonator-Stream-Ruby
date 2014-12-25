# Order Class
require 'modules/jsonable'
require 'modules/object_file_handler'
require 'modules/display_db_content'
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
