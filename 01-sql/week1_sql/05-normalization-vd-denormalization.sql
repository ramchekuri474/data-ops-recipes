/*
Week 1 — Day 5: Normalization vs Denormalization
File: 05_normalization_vs_denormalization.sql

Purpose:
- Demonstrate normalized (3NF) design
- Demonstrate denormalized design
- Explain trade-offs using SQL examples

Key idea:
Normalization = data integrity
Denormalization = query performance
*/

-- ======================================================
-- 1) NORMALIZED DESIGN (3NF)
-- ======================================================
-- Use case: OLTP / source systems
-- Goal: eliminate redundancy and enforce integrity

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  email         VARCHAR(255) UNIQUE
);

CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date  DATE NOT NULL,
  amount      DECIMAL(10,2),
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Sample data
INSERT INTO customers VALUES
  (1, 'Alice', 'alice@email.com'),
  (2, 'Bob',   'bob@email.com');

INSERT INTO orders VALUES
  (101, 1, '2026-01-10', 250.00),
  (102, 1, '2026-01-12', 120.00),
  (103, 2, '2026-01-15', 300.00);

-- Query requires JOIN (normalized)
SELECT
  o.order_id,
  o.order_date,
  o.amount,
  c.customer_name
FROM orders o
INNER JOIN customers c
  ON o.customer_id = c.customer_id;

-- ======================================================
-- 2) DENORMALIZED DESIGN
-- ======================================================
-- Use case: Analytics / reporting
-- Goal: reduce joins and improve read performance

DROP TABLE IF EXISTS order_summary;

CREATE TABLE order_summary (
  order_id      INT PRIMARY KEY,
  order_date    DATE NOT NULL,
  customer_id   INT NOT NULL,
  customer_name VARCHAR(100),
  amount        DECIMAL(10,2)
);

-- Sample data (duplicated customer_name)
INSERT INTO order_summary VALUES
  (101, '2026-01-10', 1, 'Alice', 250.00),
  (102, '2026-01-12', 1, 'Alice', 120.00),
  (103, '2026-01-15', 2, 'Bob',   300.00);

-- Query without JOIN (denormalized)
SELECT
  order_id,
  order_date,
  customer_name,
  amount
FROM order_summary;

-- ======================================================
-- 3) Trade-off summary (important notes)
-- ======================================================
-- Normalized tables:
--  - Reduce redundancy
--  - Enforce data integrity
--  - Require joins
--  - Best for OLTP systems

-- Denormalized tables:
--  - Faster reads
--  - Fewer joins
--  - Data duplication
--  - Best for analytics and reporting

-- ======================================================
-- 4) Lakehouse perspective
-- ======================================================
-- Bronze/Silver layers:
--  - Normalized or semi-normalized
--  - Data validation and integrity

-- Gold layer:
--  - Denormalized
--  - Optimized for BI and dashboards

-- ======================================================
-- End of Day 5
-- ======================================================