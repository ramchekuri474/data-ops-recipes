/* 
Day 1: SQL Basics — PK vs UNIQUE vs FK

Goal:
- Create tables with PRIMARY KEY, UNIQUE, and FOREIGN KEY
- Understand what each constraint enforces
- Learn how to validate FK-like integrity even when FK is not enforced
*/

-- Clean-up (run if your SQL engine supports DROP TABLE IF EXISTS)
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;

-- 1) Parent table: customers
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,                 -- Primary Key: unique + not null
  email       VARCHAR(255) NOT NULL,             -- Unique Key: ensures email is unique (can be NULL in some DBs)
  full_name   VARCHAR(100) NOT NULL
);

-- 2) Child table: sales
CREATE TABLE sales (
  sale_id     INT PRIMARY KEY,
  customer_id INT NOT NULL,
  amount      DECIMAL(10,2) NOT NULL,
  sale_date   DATE NOT NULL,

  -- Foreign Key: sales.customer_id must exist in customers.customer_id
  CONSTRAINT fk_sales_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3) Insert valid customer rows
INSERT INTO customers (customer_id, email, full_name)
VALUES
  (1, 'alice@example.com', 'Alice Johnson'),
  (2, 'bob@example.com',   'Bob Smith');

-- 4) Insert valid sales rows (customer exists)
INSERT INTO sales (sale_id, customer_id, amount, sale_date)
VALUES
  (101, 1, 250.00, '2026-01-26'),
  (102, 1,  75.50, '2026-01-27'),
  (103, 2, 120.00, '2026-01-27');


-- 5) Example: FK violation (should fail)
-- Try inserting a sale for a customer that does not exist:
-- INSERT INTO sales (sale_id, customer_id, amount, sale_date)
-- VALUES (104, 999, 10.00, '2026-01-28');

-- 6) Query: show data
SELECT * FROM customers;
SELECT * FROM sales;

-- 7) If FK constraints are NOT enforced (common in lakehouse),
-- you can detect "orphan" facts using a LEFT JOIN + NULL filter:

-- Orphan sales: sales records with no matching customer
SELECT c.full_name, s.sale_id, s.amount, s.sale_date
FROM sales s
LEFT JOIN customers c
  ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
