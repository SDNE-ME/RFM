# RFM (Recency, Frequency, Monetary) Analysis

## Overview
This project is a data analysis case study inspired by a YouTube tutorial. The goal of the project is to explore, clean, and analyze a dataset to extract meaningful insights that can support decision-making.

Unlike the original tutorial which used Google BigQuery, this implementation was done using **MySQL**, demonstrating how similar analytical tasks can be performed in a relational database environment.

---

## Objectives
- Clean and prepare raw data for analysis
- Perform exploratory data analysis (EDA)
- Answer key business questions using SQL
- Generate insights from structured data

---

## Tools & Technologies
- **Database:** MySQL
- **Language:** SQL
- **Environment:** MySQL Workbench
- **Version Control:** Git & GitHub

---

## Dataset
- Source: (youtube: https://youtu.be/Da960TW5tf4?si=DmXCCcOqohtxLNtL)
- Description:
  - Contains information on (sales, customers, productsID)
  - Includes fields such as:
    - `Recency`
    - `Frequency`
    - `Monetary`

---

## Data Cleaning Steps
- Removed duplicates
- Handled missing values
- Standardized column formats
- Converted data types where necessary

---

## Key Analysis Performed
- Aggregations using `GROUP BY`
- Filtering using `WHERE` and `HAVING`
- Joins between multiple tables
- Sorting and ranking results
- Identifying trends and patterns

---

## Sample Business Questions Answered
- What are the top-performing categories/products?
- Which time period had the highest activity/sales?
- Who are the highest contributing customers?
- What trends can be observed over time?

---

## Key Insights
- The majority of customers fall into mid-tier segments such as Engaged and Promising, indicating strong potential for conversion into high-value customers.
- High-value customers (Champions) represent a small portion of the customer base, suggesting an opportunity to improve customer lifetime value.
- Approximately 24% of customers fall into At Risk or Requires Attention segments, highlighting a significant churn risk.
- Loyal VIP customers form a strong base and can be strategically nurtured into Champions to drive revenue growth.
- The low number of Lost/Inactive customers suggests that proactive retention strategies can still recover at-risk users.

---
## 🚨 Recommendation: Urgent Retention Campaign

A significant portion of customers fall into the **At Risk** and **Requires Attention** segments, representing a high potential for churn.

To address this, the business should implement an urgent retention strategy focused on re-engaging these customers before they become inactive.

### Suggested Actions:
- Launch personalized email or SMS campaigns targeting at-risk customers
- Offer discounts, promotions, or loyalty incentives to encourage repeat purchases
- Monitor customer activity and trigger follow-ups when engagement drops
- Collect customer feedback to understand and resolve pain points

### Expected Impact:
- Reduced customer churn
- Improved customer retention rates
- Increased repeat purchases and overall revenue

---

## How to Run This Project
1. Install MySQL Server
2. Import the dataset into MySQL
3. Open your SQL environment (e.g., MySQL Workbench)
4. Run the SQL scripts in the `/queries` folder

---

## Acknowledgment
This project was inspired by a YouTube tutorial, with modifications to use MySQL instead of BigQuery.

