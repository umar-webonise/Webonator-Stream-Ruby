# Main script to Test models and mirgrations
require 'active_record'
require './environment'
require './models/person'
require './models/post'
require './models/account'
require './db/migrate/create_people_table'
require './db/migrate/create_posts_table'
require './db/migrate/create_accounts_table'
require './db/migrate/add_type_in_people'

CreatePeopleTable.migrate(:up)
CreatePostTable.migrate(:up)
CreateAccountTable.migrate(:up)
AddTypeToPeople.migrate(:change)

user = User.create(
  name: 'umar',
  email: 'umar.s@gmail.com',
  type: 'User'
)

admin = Admin.create(
  name: 'qasim',
  email: 'qasim.s@gmail.com',
  type: 'Admin'
)

post = Post.new(content: 'Whats People', description: 'Howz life')
post.user = user
post.save

post = Post.new(content: 'Bye People', description: 'Have a nice day')
post.user = user
post.save

account = Account.new(account_no: '3123')
account.admin = admin
account.save

account = Account.new(account_no: '2121')
account.admin = admin
account.save

require './display_db_contents'

CreatePeopleTable.migrate(:down)
CreatePostTable.migrate(:down)
CreateAccountTable.migrate(:down)
