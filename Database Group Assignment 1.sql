-- MySQL querry file for creating a bookstore database called BookstoreDB with various tables and sample input data

-- 1. Creating the Database
CREATE DATABASE IF NOT EXISTS BookstoreDB;
USE BookstoreDB;

-- 2. Create Tables
-- Language Table
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50)
);

-- Publisher Table
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Books Table
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    price DECIMAL(10,2),
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Authors' Table
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(100)
);

-- Book-Author Relationship Table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Customer Table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Address Status Table
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50)
);

-- Country Table
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(50)
);

-- Address Table
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    country_id INT,
    status_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Customer Address Table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Shipping Method Table
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(50)
);

-- Order Status Table
CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50)
);

-- Customer Order Table
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- Order Line Table
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Order History Table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    changed_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

-- 3. Inserting Sample Data
-- Languages
INSERT INTO book_language (language_name) VALUES ('English'), ('French');

-- Publishers
INSERT INTO publisher (name) VALUES ('Penguin Books'), ('HarperCollins');

-- Authors
INSERT INTO author (last_name) VALUES ('Rowling'), ('Orwell');

-- Books
INSERT INTO book (title, price, language_id, publisher_id) VALUES
('Harry Potter and the Philosopher''s Stone', 2000, 1, 1),
('1984', 14.99, 1, 2);

-- Book Authors
INSERT INTO book_author (book_id, author_id) VALUES (1, 1), (2, 2);

-- Countries
INSERT INTO country (country_name) VALUES ('USA'), ('UK');

-- Address Statuses
INSERT INTO address_status (status_name) VALUES ('Current'), ('Old');

-- Addresses
INSERT INTO address (street, city, postal_code, country_id, status_id) VALUES
('221B Baker Street', 'London', 'NW1', 2, 1),
('742 Evergreen Terrace', 'Springfield', '62704', 1, 1);

-- Customers
INSERT INTO customer (first_name, last_name) VALUES ('Stephen', 'Oduor'), ('Damaris', 'Wanjiru');

-- Customer Addresses
INSERT INTO customer_address (customer_id, address_id) VALUES (1, 1), (2, 2);

-- Shipping Methods
INSERT INTO shipping_method (method_name) VALUES ('Standard'), ('Express');

-- Order Statuses
INSERT INTO order_status (status_name) VALUES ('Pending'), ('Shipped');

-- Orders
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id) VALUES
(1, 1, 1), (2, 2, 2);

-- Order Lines
INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 2), (2, 2, 1);

-- Order History
INSERT INTO order_history (order_id, changed_date) VALUES
(1, NOW()), (2, NOW());


-- Example Querry
-- Get all books by Orwell
SELECT b.title
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.last_name = 'Orwell';
