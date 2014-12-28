# Tells AR what db file to use
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/person_db.db'
)
