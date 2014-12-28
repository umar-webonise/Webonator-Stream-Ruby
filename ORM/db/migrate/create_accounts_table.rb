# Migration to account post table
class CreateAccountTable < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.integer :admin_id
      t.integer :account_no
    end
    puts 'ran up method'
  end

  def down
    drop_table :accounts
    puts 'ran down method'
  end
end
