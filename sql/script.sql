USE bank_analytics;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM transactions;

-- Q1: Total Deposits and Withdrawals by Month
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    transaction_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount
FROM transactions
GROUP BY month, transaction_type
ORDER BY month;

-- Q2: Top 10 Customers by Account Balance
SELECT 
    c.customer_id,
    c.name,
    c.city,
    c.occupation,
    a.account_type,
    a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
ORDER BY a.balance DESC
LIMIT 10;

-- Q3: Month over Month Transaction Growth
SELECT 
    month,
    total_txns,
    LAG(total_txns) OVER (ORDER BY month) AS prev_month_txns,
    ROUND((total_txns - LAG(total_txns) OVER (ORDER BY month)) * 100.0 / 
    LAG(total_txns) OVER (ORDER BY month), 2) AS growth_pct
FROM (
    SELECT 
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        COUNT(*) AS total_txns
    FROM transactions
    GROUP BY month
) monthly;

-- Q4: Average Balance by Account Type and City
SELECT 
    a.account_type,
    c.city,
    ROUND(AVG(a.balance), 2) AS avg_balance,
    COUNT(*) AS total_accounts
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
GROUP BY a.account_type, c.city
HAVING avg_balance > 50000
ORDER BY avg_balance DESC;

-- Q5: Dormant Customers
SELECT 
    c.customer_id,
    c.name,
    c.city,
    c.occupation,
    MAX(t.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(t.transaction_date)) AS days_inactive
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.name, c.city, c.occupation
HAVING days_inactive > 90
ORDER BY days_inactive DESC;

-- Q6: Branch-wise Performance
SELECT 
    b.branch_name,
    b.city,
    SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END) AS total_withdrawals,
    ROUND(SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE 0 END) -
    SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END), 2) AS net_flow
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY b.branch_id, b.branch_name, b.city
ORDER BY net_flow DESC;


-- Q7: High Activity Customers
WITH monthly_txns AS (
    SELECT 
        c.customer_id,
        c.name,
        DATE_FORMAT(t.transaction_date, '%Y-%m') AS month,
        COUNT(*) AS txn_count
    FROM customers c
    JOIN accounts a ON c.customer_id = a.customer_id
    JOIN transactions t ON a.account_id = t.account_id
    GROUP BY c.customer_id, c.name, month
)
SELECT 
    customer_id,
    name,
    month,
    txn_count
FROM monthly_txns
WHERE txn_count > 2
ORDER BY txn_count DESC;

-- Q8: Running Total Balance per Customer
SELECT 
    c.name,
    t.transaction_date,
    t.transaction_type,
    t.amount,
    SUM(CASE 
        WHEN t.transaction_type = 'Deposit' THEN t.amount 
        ELSE -t.amount 
    END) OVER (PARTITION BY c.customer_id ORDER BY t.transaction_date) AS running_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
ORDER BY c.customer_id, t.transaction_date;

-- Q9: RFM Scoring
WITH rfm AS (
    SELECT 
        c.customer_id,
        c.name,
        DATEDIFF(CURDATE(), MAX(t.transaction_date)) AS recency,
        COUNT(*) AS frequency,
        ROUND(SUM(t.amount), 2) AS monetary
    FROM customers c
    JOIN accounts a ON c.customer_id = a.customer_id
    JOIN transactions t ON a.account_id = t.account_id
    GROUP BY c.customer_id, c.name
)
SELECT 
    customer_id,
    name,
    recency,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY recency ASC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
FROM rfm
ORDER BY m_score DESC, f_score DESC;

-- Q10: Fraud Detection
SELECT 
    t.transaction_id,
    c.name,
    c.city,
    t.transaction_date,
    t.amount,
    ROUND(avg_txn.avg_amount, 2) AS customer_avg,
    ROUND(t.amount / avg_txn.avg_amount, 2) AS times_above_avg
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
JOIN (
    SELECT 
        a.customer_id,
        AVG(t.amount) AS avg_amount
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    GROUP BY a.customer_id
) avg_txn ON c.customer_id = avg_txn.customer_id
WHERE t.amount > 3 * avg_txn.avg_amount
ORDER BY times_above_avg DESC;

-- Q11: Cohort Retention
WITH first_txn AS (
    SELECT 
        a.customer_id,
        MIN(DATE_FORMAT(t.transaction_date, '%Y-%m')) AS cohort_month
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    GROUP BY a.customer_id
),
monthly_activity AS (
    SELECT DISTINCT
        a.customer_id,
        DATE_FORMAT(t.transaction_date, '%Y-%m') AS active_month
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
)
SELECT 
    f.cohort_month,
    m.active_month,
    COUNT(DISTINCT m.customer_id) AS active_customers
FROM first_txn f
JOIN monthly_activity m ON f.customer_id = m.customer_id
GROUP BY f.cohort_month, m.active_month
ORDER BY f.cohort_month, m.active_month;

-- Q12: Customer Segmentation by Age Group and Occupation
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25 Young'
        WHEN age BETWEEN 26 AND 35 THEN '26-35 Early Career'
        WHEN age BETWEEN 36 AND 50 THEN '36-50 Mid Career'
        WHEN age BETWEEN 51 AND 70 THEN '51-70 Senior'
    END AS age_group,
    occupation,
    COUNT(*) AS total_customers,
    ROUND(AVG(a.balance), 2) AS avg_balance,
    ROUND(SUM(a.balance), 2) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY age_group, occupation
ORDER BY age_group, avg_balance DESC;