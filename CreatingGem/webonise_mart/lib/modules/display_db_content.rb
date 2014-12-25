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
