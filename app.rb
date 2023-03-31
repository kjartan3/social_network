require_relative 'lib/database_connection'
require_relative 'lib/user_repository'

DatabaseConnection.connect('social_network')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT * FROM users;'
result = DatabaseConnection.exec_params(sql, [])


user_repository = UserRepository.new

 
user_repository.all.each do |user|
  p user
end


# user_repository.all.each do |entry|
#   p entry
# end