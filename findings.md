# Bank Transaction Analytics — Findings & Business Insights

**Project:** Bank Transaction Analytics | MySQL  
**Dataset:** 1000 Customers | 1000 Accounts | 5000 Transactions | 5 Branches  
**Author:** Jidiga Charan Reddy | B.Tech CSBS, VIT-AP University

---

## Basic Analysis (Q1 to Q4)

### Q1 — Total Deposits and Withdrawals by Month

| Month | Type | Total Transactions | Total Amount |
|---|---|---|---|
| 2025-03 | Withdrawal | 104 | ₹25,29,532 |
| 2025-04 | Deposit | 186 | ₹45,56,246 |
| 2025-04 | Withdrawal | 223 | ₹61,15,858 |
| 2025-07 | Deposit | 217 | ₹53,95,088 |
| 2025-07 | Withdrawal | 215 | ₹53,59,385 |
| 2025-11 | Withdrawal | 233 | ₹59,94,580 |
| 2026-01 | Deposit | 240 | ₹60,03,105 |
| 2026-01 | Withdrawal | 204 | ₹48,84,014 |
| 2026-03 | Deposit | 119 | ₹28,98,681 |
| 2026-03 | Withdrawal | 107 | ₹26,82,819 |

**Key Findings:**
- **January 2026** recorded the highest deposit activity — 240 transactions worth ₹60,03,105
- **November 2025** had the highest withdrawal count — 233 transactions worth ₹59,94,580
- **March 2025** was the lowest activity month with only 104 withdrawal transactions
- Withdrawals consistently exceeded deposits in most months indicating customers are spending more than saving
- Data spans **March 2025 to March 2026** — a full year of banking activity
- **Business Insight:** The bank should launch deposit-focused campaigns between August and November to counter the high withdrawal trend during those months

---

### Q2 — Top 10 Customers by Account Balance

| Rank | Customer | City | Occupation | Account Type | Balance |
|---|---|---|---|---|---|
| 1 | Varenya Chand | Pune | Teacher | Current | ₹4,97,847 |
| 2 | Zinal Raman | Delhi | Engineer | Fixed Deposit | ₹4,97,172 |
| 3 | Matthew Sahota | Mumbai | Accountant | Savings | ₹4,96,892 |
| 4 | Forum Solanki | Mumbai | Engineer | Recurring Deposit | ₹4,94,265 |
| 5 | Nachiket Ram | Pune | Student | Recurring Deposit | ₹4,93,332 |
| 6 | Zashil Khurana | Hyderabad | Student | Recurring Deposit | ₹4,92,496 |
| 7 | Urishilla Nori | Hyderabad | Nurse | Savings | ₹4,92,051 |
| 8 | Abdul D'Alia | Delhi | Engineer | Current | ₹4,90,644 |
| 9 | Chanchal Raghavan | Hyderabad | Accountant | Current | ₹4,90,573 |
| 10 | Abha Sarna | Delhi | Lawyer | Recurring Deposit | ₹4,89,916 |

**Key Findings:**
- All top 10 customers hold balances close to ₹4.9 lakhs — near the ₹5 lakh maximum
- **Varenya Chand** (Pune, Teacher) holds the highest balance of ₹4,97,847
- Cities represented: Pune, Delhi, Mumbai, Hyderabad — wealth is spread across cities
- Notably **2 Students** appear in the top 10 — Nachiket Ram and Zashil Khurana
- **Recurring Deposit** is the most common account type among top customers (4 out of 10)
- **Business Insight:** High balance customers are diverse in occupation and city — the bank should offer premium services to all segments, not just traditional high-income groups

---

### Q3 — Month over Month Transaction Volume Growth
- Transaction volumes fluctuate month to month with both positive and negative growth percentages
- The LAG window function compares each month's transaction count against the previous month
- Some months show strong growth while others show decline — typical pattern in banking data
- **Business Insight:** Tracking MoM growth helps identify seasonal patterns and plan targeted campaigns during low activity months

---

### Q4 — Average Balance by Account Type and City
- Only combinations with average balance above ₹50,000 are included in results
- Fixed Deposit accounts tend to have higher average balances as customers commit larger sums
- Results show a good mix of all 4 account types across 8 cities
- **Business Insight:** Cities with lower average balances in certain account types are opportunities for upselling — offering better interest rates to attract more deposits

---

## Customer Analysis (Q5 to Q8)

### Q5 — Dormant Customers (No Transactions in Last 90 Days)

**Summary:**
- **280 out of 1000 customers** are dormant — that is **28% of the entire customer base**
- Dormancy threshold: no transactions in the last 90 days
- Inactive period ranges from **91 days to 366 days**

**Most Inactive Customers:**
| Customer | City | Occupation | Last Transaction | Days Inactive |
|---|---|---|---|---|
| Kashish Lad | Pune | Student | 2025-03-16 | 366 days |
| Elijah Luthra | Delhi | Businessman | 2025-03-21 | 361 days |
| Darika Lanka | Bangalore | Accountant | 2025-03-25 | 357 days |
| Jonathan Varghese | Pune | Businessman | 2025-04-14 | 337 days |
| Triya Brar | Mumbai | Nurse | 2025-04-21 | 330 days |

**Key Findings:**
- **Pune** has the highest number of dormant customers
- **Businessmen and Doctors** appear frequently in the dormant list
- Several customers have been inactive for nearly a full year — serious churn risk
- **Business Insight:** 28% dormancy is alarmingly high. The bank should immediately launch a re-engagement campaign targeting customers inactive for 180+ days with personalized offers, fee waivers, or bonus interest rates

---

### Q6 — Branch-wise Performance (Deposits vs Withdrawals)

| Branch | City | Total Deposits | Total Withdrawals | Net Flow |
|---|---|---|---|---|
| MG Road Branch | Bangalore | ₹1,18,51,920 | ₹1,12,34,392 | **+₹6,17,527** ✅ |
| Anna Nagar Branch | Chennai | ₹1,40,43,751 | ₹1,40,68,860 | -₹25,108 |
| Connaught Place | Delhi | ₹1,13,72,000 | ₹1,22,03,586 | -₹8,31,585 |
| Bandra Branch | Mumbai | ₹1,09,87,914 | ₹1,20,96,922 | -₹11,09,008 |
| Hitech City Branch | Hyderabad | ₹1,22,20,487 | ₹1,36,51,845 | **-₹14,31,357** ⚠️ |

**Key Findings:**
- **MG Road Bangalore** is the only branch with positive net flow — strongest performing branch
- **Anna Nagar Chennai** has the highest total transaction volumes overall
- **Hitech City Hyderabad** is the worst performing branch with the highest net outflow of -₹14,31,357
- Mumbai and Delhi branches are also in negative net flow territory
- **Business Insight:** Bangalore branch should be studied as a success model. Hyderabad branch needs urgent investigation — the high withdrawal rate could indicate customer dissatisfaction or stronger competition from nearby banks

---

### Q7 — High Activity Customers (More than 2 Transactions/Month)
- With 5000 transactions across 1000 customers the average is 5 transactions per customer per year
- Customers transacting more than 2 times in a single month are flagged as high activity
- These customers represent the most engaged segment of the bank
- **Business Insight:** High activity customers are prime candidates for premium banking products, credit cards, and loyalty reward programs to increase retention

---

### Q8 — Running Total Balance per Customer Over Time
- Running balance tracks each customer's net financial position after every transaction
- Customers with more deposits show a steadily growing running balance
- Customers with more withdrawals show a declining trend over time
- **Business Insight:** Relationship managers can use running balance trends to identify financially stressed customers early and offer suitable products like personal loans or overdraft facilities

---

## Advanced Analysis (Q9 to Q12)

### Q9 — RFM Scoring (Recency, Frequency, Monetary)
- **997 customers** were successfully scored across all 3 RFM dimensions
- Scores range from 1 to 5 using NTILE(5) window function
- r_score 1 = most recent | r_score 5 = most inactive
- f_score 5 = highest frequency | m_score 5 = highest monetary value

**Top RFM Customers:**
| Customer | Recency | Frequency | Monetary | R Score | F Score | M Score | Status |
|---|---|---|---|---|---|---|---|
| Falan Mall | 10 days | 2 | ₹65,311 | 1 | 5 | 5 | 🏆 Best Customer |
| Ishaan Agrawal | 22 days | 2 | ₹65,770 | 2 | 5 | 5 | ✅ Active + High Value |
| Fariq Peri | 216 days | 2 | ₹68,348 | 5 | 5 | 5 | ⚠️ High Value but Dormant |
| Chanakya Chawla | 212 days | 2 | ₹68,261 | 5 | 5 | 5 | ⚠️ High Value but Dormant |

**Key Findings:**
- **Falan Mall** is the best overall customer — high value, high frequency, transacted just 10 days ago
- Several high monetary value customers have r_score of 5 — they are valuable but at serious churn risk
- Most customers have a frequency of only 2-3 transactions — overall engagement is low
- **Business Insight:** RFM segmentation allows the bank to personalize outreach — reward active high-value customers like Falan Mall with premium benefits, and urgently re-engage dormant high-value customers like Fariq Peri before they leave

---

### Q10 — Fraud Detection (Transactions Above 3x Customer Average)

| Transaction ID | Customer | City | Date | Amount | Customer Avg | Times Above Avg |
|---|---|---|---|---|---|---|
| 1963 | Praneel Dewan | Delhi | 2026-03-13 | ₹46,823 | ₹11,430 | **4.10x** 🚨 |
| 293 | Jacob Suresh | Bangalore | 2025-03-22 | ₹46,681 | ₹13,066 | 3.57x |
| 3024 | Hitesh Shankar | Chennai | 2026-01-12 | ₹47,936 | ₹13,697 | 3.50x |
| 24 | Brinda Mandal | Delhi | 2025-10-08 | ₹35,706 | ₹11,251 | 3.17x |
| 4376 | Ekbal Balasubramanian | Delhi | 2025-08-19 | ₹47,013 | ₹14,858 | 3.16x |
| 2434 | Viraj Ravel | Kolkata | 2025-06-08 | ₹44,040 | ₹13,979 | 3.15x |
| 1532 | Jonathan Mall | Chennai | 2025-11-29 | ₹41,253 | ₹13,398 | 3.08x |
| 1466 | Mekhala Nayak | Chennai | 2026-02-21 | ₹49,940 | ₹16,537 | 3.02x |
| 3510 | Saumya Krish | Hyderabad | 2025-05-06 | ₹36,797 | ₹12,172 | 3.02x |

**Key Findings:**
- **9 suspicious transactions** flagged out of 5000 total — 0.18% fraud rate
- **Praneel Dewan** (Delhi) has the most suspicious transaction — ₹46,823 which is 4.10x his usual average of ₹11,430
- **Delhi and Chennai** are the most flagged cities with 3 suspicious transactions each
- **Mekhala Nayak** made the highest flagged transaction amount of ₹49,940
- **Business Insight:** All 9 flagged transactions should be immediately verified with customers via SMS or call. Implementing real-time alerts for transactions above 3x average would significantly improve fraud prevention

---

### Q11 — Cohort Retention (Monthly Customer Return Rate)
- Customers are grouped by the month of their very first transaction
- Each subsequent month tracks how many customers from that cohort returned to transact
- Retention naturally declines over time for all cohorts
- Early cohorts with stronger retention indicate successful customer onboarding
- **Business Insight:** Cohorts showing rapid drop-off in the first 60-90 days need better early engagement strategies such as welcome offers and onboarding support

---

### Q12 — Customer Segmentation by Age Group and Occupation

| Age Group | Top Occupation | Avg Balance | Total Customers |
|---|---|---|---|
| 18-25 Young | Student | ₹2,94,520 | 17 |
| 18-25 Young | Accountant | ₹2,94,152 | 16 |
| 26-35 Early Career | Engineer | ₹3,13,597 | 25 |
| 26-35 Early Career | Lawyer | ₹2,68,746 | 28 |
| 36-50 Mid Career | Accountant | ₹2,55,124 | 40 |
| 36-50 Mid Career | Businessman | ₹2,52,609 | 42 |
| 51-70 Senior | Businessman | ₹2,70,409 | 38 |
| 51-70 Senior | Nurse | ₹2,67,784 | 45 |

**Key Findings:**
- **Engineers aged 26-35** have the highest average balance of ₹3,13,597 across all segments
- **Students aged 18-25** hold high average balances of ₹2,94,520 — likely family-supported
- **36-50 Mid Career Accountants** have the largest customer count of 40 in their group
- **Senior Nurses (51-70)** are the largest single group with 45 customers
- **Business Insight:** Young students with high balances are a valuable untapped segment — the bank should target them early with long-term savings, SIP, and investment products to build lifetime customer value

---

## Summary of Key Business Recommendations

| # | Recommendation | Based On |
|---|---|---|
| 1 | Re-engage **280 dormant customers** — 28% of the base is inactive | Q5 |
| 2 | Investigate **Hyderabad branch** — worst net outflow of -₹14.3 lakhs | Q6 |
| 3 | Replicate **Bangalore branch** success model across other branches | Q6 |
| 4 | Verify **9 flagged fraud transactions** — especially Praneel Dewan at 4.10x | Q10 |
| 5 | Target **young students** with investment products — high balance segment | Q12 |
| 6 | Reward **Falan Mall and similar** high RFM customers with premium benefits | Q9 |
| 7 | Launch **deposit campaigns in Aug-Nov** to counter high withdrawal months | Q1 |
| 8 | Offer loyalty rewards to **high frequency customers** to increase engagement | Q7 |
