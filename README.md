# Bank Transaction Analytics

A end-to-end data analytics project built on a simulated banking dataset using Python and MySQL. The project answers 12 real business questions that a data analyst would encounter in the banking domain.

---

## Project Overview

| Detail | Info |
|---|---|
| Database | MySQL |
| Dataset Size | 1000 Customers, 5000 Transactions |
| Total Tables | 4 |
| Total Queries | 12 |
| Author | Jidiga Charan Reddy |
| University | VIT-AP University, B.Tech CSBS |

---

## Database Design

| Table | Key Columns |
|---|---|
| customers | customer_id, name, age, gender, city, occupation, join_date |
| accounts | account_id, customer_id, account_type, branch_id, balance, opened_date |
| transactions | transaction_id, account_id, transaction_date, amount, transaction_type |
| branches | branch_id, branch_name, city, state |

---

## Business Questions Answered

### Basic Analysis (Q1 to Q4)

| Query | Business Question | SQL Concept |
|---|---|---|
| Q1 | Total deposits and withdrawals by month | GROUP BY, DATE functions |
| Q2 | Top 10 customers by account balance | ORDER BY, LIMIT, JOIN |
| Q3 | Month-over-month transaction volume growth | LAG, Window Function |
| Q4 | Average balance by account type and city | GROUP BY, HAVING |

### Customer Analysis (Q5 to Q8)

| Query | Business Question | SQL Concept |
|---|---|---|
| Q5 | Dormant customers — no transactions in last 90 days | Subquery, DATEDIFF |
| Q6 | Branch-wise performance — deposits vs withdrawals | GROUP BY, CASE WHEN |
| Q7 | High activity customers — more than 2 transactions/month | CTE, COUNT |
| Q8 | Running total balance per customer over time | SUM with Window Function |

### Advanced Analysis (Q9 to Q12)

| Query | Business Question | SQL Concept |
|---|---|---|
| Q9 | RFM scoring — Recency, Frequency, Monetary | CTE, NTILE, RANK |
| Q10 | Fraud detection — transactions above 3x customer average | Subquery, AVG |
| Q11 | Cohort retention — how many customers return monthly | CTE, Date Logic |
| Q12 | Customer segmentation by age group and occupation | CASE WHEN, GROUP BY |

---

## SQL Concepts Covered

| Category | Concepts |
|---|---|
| Basics | GROUP BY, ORDER BY, HAVING, WHERE, LIMIT, JOINS |
| Date Logic | DATEDIFF, DATE_FORMAT, MONTH(), YEAR() |
| Subqueries | Correlated subqueries, IN, EXISTS, scalar subqueries |
| CTEs | WITH clause, multi-step CTEs, chained CTEs |
| Window Functions | LAG, LEAD, RANK, NTILE, SUM OVER, ROW_NUMBER |
| Conditionals | CASE WHEN, IF, COALESCE, NULLIF |

---

## Project File Structure

```
bank-transaction-analytics/
├── data/
│   ├── generate_data.py       -- Python script to generate dataset
│   ├── customers.csv          -- 1000 customer records
│   ├── accounts.csv           -- 1000 account records
│   ├── transactions.csv       -- 5000 transaction records
│   └── branches.csv           -- 5 branch records
├── sql/
│   ├── 01_create_tables.sql   -- CREATE TABLE statements
│   ├── 03_basic_analysis.sql  -- Queries for Q1 to Q4
│   ├── 04_customer_analysis.sql -- Queries for Q5 to Q8
│   └── 05_advanced_analysis.sql -- Queries for Q9 to Q12
├── findings.md                -- Business insights for all 12 queries
└── README.md                  -- Project overview
```

---

## How to Run

### Step 1 - Install Requirements
```bash
pip install faker mysql-connector-python pandas
```

### Step 2 - Set Up Database
Run the following in MySQL Workbench or MySQL command line:
```sql
CREATE DATABASE IF NOT EXISTS bank_analytics;
USE bank_analytics;
```
Then execute `sql/01_create_tables.sql` to create all 4 tables.

### Step 3 - Generate Data
Open `data/generate_data.py`, update your MySQL password, and run:
```bash
python data/generate_data.py
```
This inserts 1000 customers, 1000 accounts, 5 branches, and 5000 transactions.

### Step 4 - Run SQL Queries
Open MySQL Workbench, connect to `bank_analytics` database, and run the SQL files in order:
- `sql/03_basic_analysis.sql`
- `sql/04_customer_analysis.sql`
- `sql/05_advanced_analysis.sql`

---

## Key Findings

- 28% of customers (280 out of 1000) are dormant with no transactions in the last 90 days
- MG Road Bangalore is the only branch with a positive net flow of +6.17 lakhs
- Hitech City Hyderabad has the worst net outflow of -14.3 lakhs
- 9 suspicious transactions were flagged — Praneel Dewan's transaction was 4.10x his average
- Engineers aged 26-35 hold the highest average balance of 3,13,597
- January 2026 recorded the highest deposit activity with 240 transactions

For detailed insights on all 12 queries, see [findings.md](findings.md).

---

## Tools and Technologies

- Python 3.x
- MySQL 8.0
- MySQL Workbench
- Faker Library
- mysql-connector-python
- Pandas

---

*Jidiga Charan Reddy | B.Tech CSBS | VIT-AP University | Data Analyst Portfolio Project*
