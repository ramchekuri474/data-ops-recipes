/*
Week 1 — Day 4: SQL Window Functions
File: 04_window_functions.sql

Focus:
- ROW_NUMBER
- RANK / DENSE_RANK
- LAG / LEAD
- Running totals
*/

-- =================================
-- 1) Sample table
-- =================================
DROP TABLE IF EXISTS employee_sales;

CREATE TABLE employee_sales (
  emp_id    INT,
  sale_id   INT,
  amount    DECIMAL(10,2),
  sale_date DATE
);

INSERT INTO employee_sales VALUES
  (1, 101, 100.00, '2026-01-01'),
  (1, 102, 200.00, '2026-01-03'),
  (1, 103, 200.00, '2026-01-05'),
  (2, 201, 150.00, '2026-01-02'),
  (2, 202, 150.00, '2026-01-04'),
  (3, 301,  80.00, '2026-01-01');

-- =================================
-- 2) ROW_NUMBER(): latest sale per employee
-- =================================
SELECT
  emp_id,
  sale_id,
  amount,
  sale_date
FROM (
  SELECT
    emp_id,
    sale_id,
    amount,
    sale_date,
    ROW_NUMBER() OVER (
      PARTITION BY emp_id
      ORDER BY sale_date DESC
    ) AS rn
  FROM employee_sales
) t
WHERE rn = 1;

-- =================================
-- 3) RANK vs DENSE_RANK
-- =================================
SELECT
  emp_id,
  sale_id,
  amount,
  RANK() OVER (
    PARTITION BY emp_id
    ORDER BY amount DESC
  ) AS rank_amt,
  DENSE_RANK() OVER (
    PARTITION BY emp_id
    ORDER BY amount DESC
  ) AS dense_rank_amt
FROM employee_sales;

-- =================================
-- 4) LAG(): previous sale amount (change detection)
-- =================================
SELECT
  emp_id,
  sale_date,
  amount,
  LAG(amount) OVER (
    PARTITION BY emp_id
    ORDER BY sale_date
  ) AS prev_amount
FROM employee_sales;

-- =================================
-- 5) LEAD(): next sale amount
-- =================================
SELECT
  emp_id,
  sale_date,
  amount,
  LEAD(amount) OVER (
    PARTITION BY emp_id
    ORDER BY sale_date
  ) AS next_amount
FROM employee_sales;

-- =================================
-- 6) Running total per employee
-- =================================
SELECT
  emp_id,
  sale_date,
  amount,
  SUM(amount) OVER (
    PARTITION BY emp_id
    ORDER BY sale_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total
FROM employee_sales;