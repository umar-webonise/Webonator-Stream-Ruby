# Class oersin and its relations classes
class People < ActiveRecord::Base; end
# User Model
class User < People
  has_many :posts
end
# Admin Model
class Admin < People
  has_many :accounts
end
