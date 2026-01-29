/* 
Week 1 — Day 2: JOINs + LEFT JOIN importance + MAX sales by employee + WHERE vs HAVING


Goals:
1) Understand INNER vs LEFT JOIN (and why LEFT JOIN matters)
2) Use LEFT JOIN + NULL filter as an anti-join (find missing)
3) Find max number of sales by employee (handle ties)
4) Explain/Practice WHERE vs HAVING
*/

-- =========================
-- 0) Reset (safe re-run)
-- =========================
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;

-- =========================
-- 1) Create sample tables
-- =========================
CREATE TABLE employees (
  emp_id   INT PRIMARY KEY,
  name     VARCHAR(100) NOT NULL,
  dept     VARCHAR(50)
);

CREATE TABLE sales (
  sale_id  INT PRIMARY KEY,
  emp_id   INT,
  amount   DECIMAL(10,2) NOT NULL,
  sale_dt  DATE NOT NULL,
  CONSTRAINT fk_sales_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- =========================
-- 2) Insert sample data
-- =========================
INSERT INTO employees (emp_id, name, dept) VALUES
  (1, 'Alice', 'Data'),
  (2, 'Bob',   'Data'),
  (3, 'Carol', 'Ops'),
  (4, 'Dan',   'Ops');        -- Dan will have 0 sales

INSERT INTO sales (sale_id, emp_id, amount, sale_dt) VALUES
  (101, 1, 100.00, '2026-01-10'),
  (102, 1, 200.00, '2026-01-11'),
  (103, 1,  50.00, '2026-01-12'),
  (104, 2, 300.00, '2026-01-12'),
  (105, 2,  20.00, '2026-01-13'),
  (106, 3,  40.00, '2026-01-14');  -- Carol has 1 sale

-- ==========================================================
-- 3) INNER JOIN vs LEFT JOIN (why LEFT JOIN is important)
-- ==========================================================

-- INNER JOIN: returns only employees who have at least 1 sale
SELECT e.emp_id, e.name, s.sale_id, s.amount
FROM employees e
INNER JOIN sales s
  ON e.emp_id = s.emp_id
ORDER BY e.emp_id, s.sale_id;

-- LEFT JOIN: returns ALL employees (including those with 0 sales)
SELECT e.emp_id, e.name, s.sale_id, s.amount
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id
ORDER BY e.emp_id, s.sale_id;

-- ==========================================================
-- 4) Anti-join pattern (find missing / no matching records)
-- ==========================================================

-- Employees with NO sales (classic data completeness check)
SELECT e.emp_id, e.name
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id
WHERE s.emp_id IS NULL;

-- ==========================================================
-- 5) Sales count per employee + MAX sales (handle ties)
-- ==========================================================

-- Sales count per employee (includes 0 sales because LEFT JOIN)
SELECT
  e.emp_id,
  e.name,
  COUNT(s.sale_id) AS total_sales
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id
GROUP BY e.emp_id, e.name
ORDER BY total_sales DESC, e.emp_id;

-- Employee(s) with the MAX number of sales (handles ties)
WITH sales_count AS (
  SELECT
    e.emp_id,
    e.name,
    COUNT(s.sale_id) AS total_sales
  FROM employees e
  LEFT JOIN sales s
    ON e.emp_id = s.emp_id
  GROUP BY e.emp_id, e.name
)
SELECT *
FROM sales_count
WHERE total_sales = (SELECT MAX(total_sales) FROM sales_count);

-- ==========================================================
-- 6) WHERE vs HAVING
-- ==========================================================
-- WHERE filters ROWS before GROUP BY (cannot use aggregates like COUNT/SUM)
-- HAVING filters GROUPS after GROUP BY (can use aggregates)

-- Example A: WHERE filters rows before aggregation
-- "Count sales per employee, but only for sales amount > 50"
SELECT
  e.emp_id,
  e.name,
  COUNT(s.sale_id) AS total_sales_over_50
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id
WHERE s.amount > 50
GROUP BY e.emp_id, e.name
ORDER BY total_sales_over_50 DESC, e.emp_id;

-- Example B: HAVING filters groups after aggregation
-- "Employees who have more than 1 sale"
SELECT
  e.emp_id,
  e.name,
  COUNT(s.sale_id) AS total_sales
FROM employees e
LEFT JOIN sales s
  ON e.emp_id = s.emp_id
GROUP BY e.emp_id, e.name
HAVING COUNT(s.sale_id) > 1
ORDER BY total_sales DESC, e.emp_id;