TRUNCATE TABLE users, posts RESTART IDENTITY;

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email) VALUES ('John', 'John@mail.com');
INSERT INTO users (username, email) VALUES ('Terry', 'Terry@mail.com');

-- INSERT INTO users (username, email) VALUES ('Bishop', 'Bishop@mail.com');

INSERT INTO posts (title, content, views, user_id) VALUES ('All about footy', 'League, record breakers', 50, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Breaking boundaries', 'All about self control...', 120, 2);

-- INSERT INTO posts (title, content, views, user_id) VALUES ('Fishing with Bishop', 'How many can you fish...', 200, 3);