
-- Inventory Optimization
-- Low-stock products that need reordering
SELECT product_id, stock_level
FROM inventory
WHERE stock_level < reorder_threshold;

-- Top-selling products by category
SELECT category_id, product_id, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY category_id, product_id
ORDER BY total_sales DESC;

-- Most recent restocking dates
SELECT product_id, MAX(restock_date) AS last_restock
FROM restocks
GROUP BY product_id;
