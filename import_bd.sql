PRAGMA foreign_keys = ON;

-- DROP TABLE IF EXISTS question_follows; 
-- DROP TABLE IF EXISTS question_likes;
-- DROP TABLE IF EXISTS replies;
-- DROP TABLE IF EXISTS questions;
-- DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    author_id INTEGER,
    question_id INTEGER,

    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    reply_user_id INTEGER NOT NULL,
    body TEXT NOT NULL, 


    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (reply_user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    like_user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (like_user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
    users (fname, lname)
VALUES
    ('Mei', 'H'),
    ('Shawna', 'H'),
    ('Luis', 'K'),
    ('Janira', 'A');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Homework', 'What exactly is going to be on the test?', 2),
    ('Lunch', 'How can we get extra time at lunch?', 3);

INSERT INTO 
    replies (question_id, parent_reply_id, reply_user_id, body)
VALUES
    (2, NULL, 2, 'NO'),
    (2, 1, 1, 'actually....that can be done');

INSERT INTO
    question_likes (like_user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Mei'), (SELECT id FROM questions WHERE title = 'Homework')),
    ((SELECT id FROM users WHERE fname = 'Shawna'), (SELECT id FROM questions WHERE title = 'Homework')),
    ((SELECT id FROM users WHERE fname = 'Janira'), (SELECT id FROM questions WHERE title = 'Lunch'));
