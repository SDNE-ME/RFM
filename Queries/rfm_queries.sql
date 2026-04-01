--Delete empty columns from the sales202512 table
ALTER TABLE dbo.sales202512
DROP COLUMN column6, column7, column8;

--Append all monthly sales table together
DROP TABLE IF EXISTS dbo.sales_2025;
SELECT * 
INTO dbo.sales_2025
FROM dbo.sales202501
UNION ALL SELECT * FROM dbo.sales202502
UNION ALL SELECT * FROM dbo.sales202503
UNION ALL SELECT * FROM dbo.sales202504
UNION ALL SELECT * FROM dbo.sales202505
UNION ALL SELECT * FROM dbo.sales202506
UNION ALL SELECT * FROM dbo.sales202507
UNION ALL SELECT * FROM dbo.sales202508
UNION ALL SELECT * FROM dbo.sales202509
UNION ALL SELECT * FROM dbo.sales202510
UNION ALL SELECT * FROM dbo.sales202511
UNION ALL SELECT * FROM dbo.sales202512;


--calculating recency, frequency, monetary, r, f, m ranks
--combine views with CTEs
DROP VIEW IF EXISTS dbo.rfm_metrics;
GO

CREATE VIEW dbo.rfm_metrics
AS
WITH analysis_date_cte AS (
  SELECT CAST('2026-03-26' AS DATE) AS analysis_date
),
rfm AS (
  SELECT 
    CustomerID,
    MAX(OrderDate) AS last_order_date,
    DATEDIFF(day, MAX(OrderDate), (SELECT analysis_date FROM analysis_date_cte)) AS recency,
    COUNT(*) AS frequency,
    SUM(OrderValue) AS monetary
  FROM dbo.sales_2025
  GROUP BY CustomerID
)
SELECT 
  rfm.*,
  ROW_NUMBER() OVER (ORDER BY recency ASC) AS r_rank,
  ROW_NUMBER() OVER (ORDER BY frequency DESC) AS f_rank,
  ROW_NUMBER() OVER (ORDER BY monetary DESC) AS m_rank
FROM rfm;
GO

--assign deciles (10=best, 1=worst)
DROP VIEW IF EXISTS dbo.rfm_scores;
GO

CREATE VIEW dbo.rfm_scores
AS
SELECT
  *,
  NTILE(10) OVER (ORDER BY r_rank DESC) AS r_score,
  NTILE(10) OVER (ORDER BY f_rank DESC) AS f_score,
  NTILE(10) OVER (ORDER BY m_rank DESC) AS m_score
FROM dbo.rfm_metrics;
GO


--total score
DROP VIEW IF EXISTS dbo.rfm_total_scores;
GO

CREATE VIEW dbo.rfm_total_scores
AS
SELECT 
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS rfm_total_score
FROM dbo.rfm_scores;
GO
-- Query the view with ordering
SELECT * FROM dbo.rfm_total_scores
ORDER BY rfm_total_score DESC;

-- Created by GitHub Copilot in SSMS - review carefully before executing

-- BI ready rfm segment table
DROP TABLE IF EXISTS dbo.rfm_segment_final;
GO

SELECT
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  rfm_total_score,
  CASE
    WHEN rfm_total_score >= 28 THEN 'Champions'
    WHEN rfm_total_score >= 24 THEN 'Loyal VIPs'
    WHEN rfm_total_score >= 20 THEN 'Potential Loyalties'
    WHEN rfm_total_score >= 16 THEN 'Promising'
    WHEN rfm_total_score >= 12 THEN 'Engaged'
    WHEN rfm_total_score >= 8 THEN 'Requires Attention'
    WHEN rfm_total_score >= 4 THEN 'At Risk'
    ELSE 'Lost/Inactive'
  END AS rfm_segment
INTO dbo.rfm_segment_final
FROM dbo.rfm_total_scores
ORDER BY rfm_total_score DESC;