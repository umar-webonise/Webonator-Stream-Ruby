# Migration to create people table
class CreatePeopleTable < ActiveRecord::Migration
  def up
    create_table :people do |t|
      t.string :name
      t.string :email
    end
    puts 'ran up method'
  end

  def down
    drop_table :people
    puts 'ran down method'
  end
end

# CreateDeckStudySessionsTable.migrate(:up)
