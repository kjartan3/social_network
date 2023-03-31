require_relative "./user"

class UserRepository
  def all
    users = []
    sql = "SELECT * FROM users;"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each { |entry| users << user_inflate(entry) }
    return users
  end

  def find(id)
    sql = "SELECT * FROM users WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    entry = result_set[0]
    return user_inflate(entry)
  end

  def create(new_user)
    sql = "INSERT INTO users (username, email) VALUES($1, $2);"
    sql_params = [new_user.username, new_user.email]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = "DELETE FROM users WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  private

  def user_inflate(entry)
    user = User.new
    user.id = entry["id"].to_i
    user.username = entry["username"]
    user.email = entry["email"]
    return user
  end
end