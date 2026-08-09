DROP table if exists basics.students;
create table basics.students (
    id serial primary key,
    name varchar(100) not null,
    email varchar(100) not null unique,
    created_at timestamp default current_timestamp,
    age INTEGER CHECK(age>=18)
);
SELECT * FROM basics.students;


-- insert data

INSERT INTO basics.students (name, email, age) VALUES
('Alice', 'alice@example.com', 20),
('Bob', 'bob@example.com', 22),
('Charlie', 'charlie@example.com', 19);
