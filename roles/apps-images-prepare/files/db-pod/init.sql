CREATE TABLE test (
       id serial PRIMARY KEY,
       text text,
       time timestamp with time zone default now()
);
