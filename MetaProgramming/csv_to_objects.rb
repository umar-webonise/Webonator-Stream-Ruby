# Program to convert CSV file in ruby Class and Onjects
require 'csv'
# Module for Csv to Object Converter
module CsvConverterObject
  def self.convert(file)
    file_name = file.gsub(/s?\.csv/, '')
    class_name = file_name.split(/_/).map(&:capitalize)
    class_name = class_name.join
    csv_class = Object.const_set(class_name, Class.new)
    options = { headers: true, header_converters: :symbol, converters: :all }
    CSV.foreach(file, options) do |row|
      csv_object = csv_class.new
      row = row.to_hash
      row.each do |instance_var, instance_vals|
        csv_class.class_eval { attr_accessor instance_var }
        csv_object.instance_variable_set("@#{instance_var}", instance_vals)
      end
      puts '---------------------------------------------------------------'
      puts csv_object.inspect
    end
  end
end

CsvConverterObject.convert('user_details.csv')
