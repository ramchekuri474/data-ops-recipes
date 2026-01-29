/*
Week 1 — Day 3: Other SQL Joins + Performance Best Practices
File: 03_other_joins_and_performance.sql

Key themes:
- RIGHT, FULL OUTER, CROSS, SELF joins
- SEMI (EXISTS) and ANTI (NOT EXISTS) joins
- Avoiding SELECT * for performance (column pruning)
*/

-- ======================================================
-- 0) Reset tables (safe re-run)
-- ======================================================
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS calendar_days;

-- ======================================================
-- 1) Base tables
-- ======================================================
CREATE TABLE employees (
  emp_id     INT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  manager_id INT
);

CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  emp_id  INT,
  amount  DECIMAL(10,2)
);

-- ======================================================
-- 2) Sample data
-- ======================================================
INSERT INTO employees (emp_id, name, manager_id) VALUES
  (1, 'Alice', NULL),
  (2, 'Bob',   1),
  (3, 'Carol', 1),
  (4, 'Dan',   2);        -- Dan has no sales

INSERT INTO sales (sale_id, emp_id, amount) VALUES
  (101, 1, 100.00),
  (102, 1, 200.00),
  (103, 2, 150.00);

-- ======================================================
-- 3) RIGHT JOIN
-- NOTE: RIGHT JOIN can usually be rewritten as LEFT JOIN
-- by swapping table order.
-- ======================================================
SELECT
  e.emp_id,
  e.name,
  s.sale_id,
  s.amount
FROM employees e
RIGHT JOIN sales s
  ON e.emp_id = s.emp_id;

-- ======================================================
-- 4) FULL OUTER JOIN (reconciliation use case)
-- Shows:
-- - employees without sales
-- - sales without employees
-- ======================================================
SELECT
  e.emp_id     AS employee_id,
  e.name       AS employee_name,
  s.sale_id    AS sale_id,
  s.amount     AS sale_amount
FROM employees e
FULL OUTER JOIN sales s
  ON e.emp_id = s.emp_id;

-- ======================================================
-- 5) FULL OUTER JOIN (SQLite-compatible version)
-- ======================================================
SELECT
  e.emp_id,
  e.name,
  s.sale_id,
  s.amount
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id

UNION

SELECT
  e.emp_id,
  e.name,
  s.sale_id,
  s.amount
FROM sales s
LEFT JOIN employees e
  ON e.emp_id = s.emp_id;

-- ======================================================
-- 6) CROSS JOIN (scaffolding / combinations)
-- Example: all store-date combinations
-- ======================================================
CREATE TABLE stores (
  store_id   INT PRIMARY KEY,
  store_name VARCHAR(50)
);

CREATE TABLE calendar_days (
  business_date DATE PRIMARY KEY
);

INSERT INTO stores VALUES
  (1, 'Store A'),
  (2, 'Store B');

INSERT INTO calendar_days VALUES
  ('2026-01-01'),
  ('2026-01-02');

SELECT
  st.store_id,
  st.store_name,
  c.business_date
FROM stores st
CROSS JOIN calendar_days c;

-- ======================================================
-- 7) SELF JOIN (employee-manager hierarchy)
-- ======================================================
SELECT
  e.emp_id   AS employee_id,
  e.name     AS employee_name,
  m.emp_id   AS manager_id,
  m.name     AS manager_name
FROM employees e
LEFT JOIN employees m
  ON e.manager_id = m.emp_id;

-- ======================================================
-- 8) SEMI JOIN (EXISTS)
-- Employees who have at least one sale
-- ======================================================
SELECT
  e.emp_id,
  e.name
FROM employees e
WHERE EXISTS (
  SELECT 1
  FROM sales s
  WHERE s.emp_id = e.emp_id
);

-- ======================================================
-- 9) ANTI JOIN (NOT EXISTS)
-- Employees with NO sales (data completeness check)
-- ======================================================
SELECT
  e.emp_id,
  e.name
FROM employees e
WHERE NOT EXISTS (
  SELECT 1
  FROM sales s
  WHERE s.emp_id = e.emp_id
);

-- ======================================================
-- 10) Performance note: Avoid SELECT *
-- ======================================================
-- BAD (reads unnecessary columns, hurts column pruning):
-- SELECT * FROM employees;

-- GOOD (reads only required columns):
SELECT
  emp_id,
  name
FROM employees;

-- ======================================================
-- End of Day 3
-- ======================================================
