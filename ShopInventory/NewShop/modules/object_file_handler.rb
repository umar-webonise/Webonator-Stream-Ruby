# To manage all the file operations required for file data base
module ObjectFileHandler
  def save
    File.open(self.class::DB_PATH, 'a+') { |file| file.puts to_json }
  end

  def set_id
    id = File.open(self.class::ID_PATH, 'r') { |file| file.read }
    self.id = id.to_i + 1
    File.open(self.class::ID_PATH, 'w') { |file| file.write(@id) }
  end

  def search_object!(name, val)
    if val.class.to_s == 'String'
      regex = /.*"@#{name}":"#{val}".*/i
    else
      regex = /.*"@#{name}":#{val}.*/
    end
    match_data = File.readlines(self.class::DB_PATH).find do |line|
      line.match(regex)
    end
    return false if match_data.to_s.empty?
    from_json!(match_data.to_s)
  end

  def remove_object
    r = /\{(?:"@\w+":(?:\d+(?:\.\d+)?,|"\w+",))+"@id":#{@id}\}\n/m
    contents = File.open(self.class::DB_PATH, 'r') { |file| file.read }
    contents = contents.gsub(r, '')
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
      object_string = "#{object_string}|#{var} = #{instance_variable_get(var)} "
    end
    object_string
  end
end
