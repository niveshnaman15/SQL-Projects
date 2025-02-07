use olist_store_analysis;
SELECT *FROM olist_customers;
SELECT *FROM olist_geolocation;
SELECT *FROM olist_order_items;
SELECT *FROM olist_order_payments;
SELECT *FROM olist_order_reviews;
SELECT *FROM olist_orders;

SET SQL_SAFE_UPDATES = 0;



-----------------------------------------------------#FIRST KPI------------------------------------------------------------------------------------------------------------------------------------
                             #Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

select
case when dayname(o.order_purchase_timestamp) in ("Saturday","Sunday") then "Weekend"
else "Weekday" 
end as Weekday_Weekend, 
count(*) AS Total_orders,
round(sum(p.payment_value)) as Total_Payment,
round(avg(p.payment_value)) as Avg_payment,
concat(
        round(sum(p.payment_value) * 100 /sum(sum(p.payment_value)) over(), 2), '%'
    ) AS Payment_Percentage
from olist_orders as o join olist_order_payments as p
on o.order_id=p.order_id
group by Weekday_Weekend;



-----------------------------------------------------# SECOND KPI-----------------------------------------------------------------------------------------------------------------------------------
							 #Number of Orders with review score 5 and payment type as credit card.
select p.payment_type,r.review_score as review_score, count(o.order_id) as order_id 
from olist_order_payments as p join olist_orders as o
on p.order_id=o.order_id  join olist_order_reviews as r 
on o.order_id=r.order_id 
where payment_type = "credit_card" and review_score = 5 ;





------------------------------------------------------#THIRD KPI---------------------------------------------------------------------------------------------------------------------------------------
							#Average number of days taken for order_delivered_customer_date for pet_shop

select 
	c.product_category_name,
	round( avg (TIMESTAMPDIFF(second, order_purchase_timestamp, order_delivered_customer_date)/(24*60*60)),2) as Average_delivery_days_for_oet_shop
from 
	olist_orders as a 
left join 
	olist_order_items as b on a.order_id = b.order_id
left join 
	olist_products as c on b.product_id = c.product_id
where
	c.product_category_name = 'pet_shop'
group by c.product_category_name;



 ----------------------------------------------------#FOURTH KPI------------------------------------------------------------------------------------------------------------------------------------------ 
                            #Average price and payment values from customers of sao paulo city
WITH Avg_Price AS (
SELECT ROUND (AVG(I.price), 2) AS Avg_Price
FROM olist_order_items AS I
JOIN olist_orders AS O ON I.order_id = O.order_id
JOIN olist_customers AS C ON O.customer_id = C.customer_id
WHERE C.customer_city = 'sao paulo'
)
SELECT
(SELECT Avg_Price FROM Avg_Price) AS Avg_Price,
ROUND (AVG(P.payment_value), 2) AS Avg_Payment_Value
FROM olist_order_payments AS P
JOIN olist_orders AS O ON P.order_id = O.order_id
JOIN olist_customers AS C ON O.customer_id = C.customer_id
WHERE C.customer_city = 'sao paulo';
    
    
    
    
    
  
    
    
    


----------------------------------------------------#FIFTH KPI-----------------------------------------------------------------------------------------------------------------------------------------------
                           # Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

select r.review_score, round(avg(datediff(o.order_delivered_customer_date,o.order_purchase_timestamp)),0)as Shipping_days 
from olist_orders as o join olist_order_reviews as r
on o.order_id=r.order_id
group by review_score
order by review_score
DESC;


---------------------------------------------------------#END-------------------------------------------------------------------------------------------------------------------




