require_relative "./post"

class PostRepository
  def all
    posts = []
    sql = "SELECT * FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each { |entry| posts << post_inflate(entry) }
    return posts
  end

  def find(id)
    sql = "SELECT * FROM posts WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    entry = result_set[0]
    return post_inflate(entry)
  end

  def create(new_post)
    sql = "INSERT INTO posts (title, content, views) VALUES($1, $2, $3);"
    sql_params = [new_post.title, new_post.content, new_post.views]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  private

  def post_inflate(entry)
    post = Post.new
    post.id = entry["id"].to_i
    post.title = entry["title"]
    post.content = entry["content"]
    post.views = entry["views"].to_i
    return post
  end
end