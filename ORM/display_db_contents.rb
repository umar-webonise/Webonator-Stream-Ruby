# To display db contents
require 'active_record'
require './environment'
require './models/person'
require './models/post'
require './models/account'

people = People.all
people.each do |u|
  puts u.inspect
  puts '----------------------------'
end

posts = Post.all
posts.each do |p|
  puts p.inspect
  puts '----------------------------'
end

accounts = Account.all
accounts.each do |a|
  puts a.inspect
  puts '----------------------------'
end
