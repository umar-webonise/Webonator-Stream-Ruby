# Migraton to add type reference in People
class AddTypeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :type, :string
    puts 'ran change method'
  end
end
