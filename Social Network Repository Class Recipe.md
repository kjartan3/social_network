# Social Media Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `recipes`*

```
# EXAMPLE

Table: recipes

Columns:
id | title | release_year | artist_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY;
TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email) VALUES ('John', 'John@mail.com');
INSERT INTO users (username, email) VALUES ('Terry', 'Terry@mail.com');

INSERT INTO posts (title, content, views, user_id) VALUES ('All about footy', 'League, record breakers', 50, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Breaking Boundaries', 'All about self control...', 120, 2);


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/student.rb)
class User
end

# Repository class
# (in lib/student_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/student.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email
end

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    all_users = []


    # Executes the SQL query:
    SELECT * FROM users;

    # Returns an array of Album objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    SELECT * FROM users WHERE id = $1;

    # Returns a single Album object.
  end

  def create(new_user)
    INSERT INTO users (username, email) VALUES($1, $2);

  end

  def delete
    DELETE FROM users WHERE id = $id;

  end
end
```
all, find, create and delete
## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all users

repo = UserRepository.new

all_users = repo.all

all_users.length # =>  2

all_users[0].id # =>  1
all_users[0].username # =>  'John'
all_users[0].email # => 'John@mail.com'

all_users[1].id # =>  2
all_users[1].username # =>  'Terry'
all_users[1].email # => 'Terry@mail.com'

# 2
# Get a single recipe

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.username # =>  'John'
user.email # => 'John@mail.com'

# 3
# Create a new user

repo = UserRepository.new

new_user = User.new

new_user.id # =>  3
new_user.username # =>  'Bishop'
new_user.email # => 'Bishop@mail.com'

repo.create(new_user)
repo.all

# 4
# Delete a user

repo = UserRepository.new
repo.delete(1)
repo.all 
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/post_repository_spec.rb
# file: spec/user_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_user.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  it 'returns all users' do
    repo = RecipeRepository.new
    recipes = repo.all
      expect(recipes.length).to eq 2
      expect(recipes[0].name).to eq 'Pasta'
      expect(recipes[0].average_cooking_time).to eq '40'
      expect(recipes[0].rating).to eq '5'
      expect(recipes[1].name).to eq 'Burger'
      expect(recipes[1].average_cooking_time).to eq '20'
      expect(recipes[1].rating).to eq '4'
  end

  it 'returns single recipe pasta' do
    repo = RecipeRepository.new
    recipe = repo.find(1)
      expect(recipe.name).to eq 'Pasta'
      expect(recipe.average_cooking_time).to eq '40'
      expect(recipe.rating).to eq '5'
  end
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->