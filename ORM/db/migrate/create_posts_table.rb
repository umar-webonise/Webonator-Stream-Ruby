# Migration to create post table
class CreatePostTable < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.integer :user_id
      t.string :content
      t.string :description
    end
    puts 'ran up method'
  end

  def down
    drop_table :posts
    puts 'ran down method'
  end
end
