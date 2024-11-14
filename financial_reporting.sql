
-- Financial Reporting
-- Monthly revenue vs expense report
SELECT DATE_TRUNC('month', transaction_date) AS month, 
       SUM(CASE WHEN transaction_type = 'revenue' THEN amount ELSE 0 END) AS total_revenue,
       SUM(CASE WHEN transaction_type = 'expense' THEN amount ELSE 0 END) AS total_expense
FROM finances
GROUP BY month;

-- Quarterly financial summaries
SELECT DATE_TRUNC('quarter', transaction_date) AS quarter, 
       SUM(amount) AS total
FROM finances
GROUP BY quarter;

-- Cumulative profit growth
SELECT transaction_date, SUM(amount) OVER (ORDER BY transaction_date) AS cumulative_profit
FROM finances;
