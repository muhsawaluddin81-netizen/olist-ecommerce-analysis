-- BUSSINES QUESTION 1
SELECT a.customer_city, 
COUNT(c.order_id) AS total_transaksi,
ROUND(AVG(c.payment_value),2) AS average_payment
FROM portofolio.olist_customers AS a 
JOIN portofolio.olist_orders AS b ON a.customer_id=b.customer_id
JOIN portofolio.olist_order_payments AS c ON b.order_id=c.order_id
GROUP BY customer_city
HAVING COUNT(c.order_id) > 50
ORDER BY average_payment DESC;

-- BUSSINES QUESTION 2
SELECT * FROM(
SELECT a.product_category_name_english AS product_category,
		COUNT(c.order_item_id) AS jumlah_item_terjual
FROM portofolio.product_category_name_translation AS a JOIN portofolio.olist_products AS b 
ON a.product_category_name=b.product_category_name
JOIN portofolio.olist_order_items AS c
ON b.product_id=c.product_id
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 3) AS tertinggi
UNION ALL
SELECT * FROM(
SELECT a.product_category_name_english AS product_category,
		COUNT(c.order_item_id) AS jumlah_item_terjual
FROM portofolio.product_category_name_translation AS a JOIN portofolio.olist_products AS b 
ON a.product_category_name=b.product_category_name
JOIN portofolio.olist_order_items AS c
ON b.product_id=c.product_id
GROUP BY 1 
ORDER BY 2 ASC
LIMIT 3) AS terendah;

-- BUSSINES QUESTION 3
SELECT a.product_category_name_english AS product_category,
  COUNT(c.order_item_id) AS jumlah_item_terjual,
  e.customer_city
FROM portofolio.product_category_name_translation AS a
JOIN portofolio.olist_products AS b ON a.product_category_name = b.product_category_name
JOIN portofolio.olist_order_items AS c ON b.product_id = c.product_id
JOIN portofolio.olist_orders AS d ON c.order_id = d.order_id
JOIN portofolio.olist_customers AS e ON d.customer_id = e.customer_id
WHERE a.product_category_name_english = 'bed_bath_table'
GROUP BY a.product_category_name_english, e.customer_city
ORDER BY jumlah_item_terjual DESC
LIMIT 10;

-- BUSSINES QUESTION 4
SELECT a.customer_city,
  COUNT(b.order_id) AS number_of_transactions,
  ROUND(AVG(DATE_PART('day',
    b.order_delivered_customer_date -
    b.order_delivered_carrier_date))::NUMERIC, 2) AS average_delivery_duration
FROM portofolio.olist_customers AS a
JOIN portofolio.olist_orders AS b ON a.customer_id = b.customer_id
WHERE b.order_delivered_customer_date IS NOT NULL
AND b.order_delivered_carrier_date IS NOT NULL
AND b.order_delivered_customer_date > b.order_delivered_carrier_date
AND DATE_PART('day', b.order_delivered_customer_date - b.order_delivered_carrier_date) > 0
GROUP BY a.customer_city
HAVING COUNT(b.order_id) >= 10
ORDER BY average_delivery_duration ASC;


-- BUSSINES QUESTION 5
SELECT COUNT(review_score)AS number_of_reviews, 
ROUND(COUNT(review_score) * 100.0 / SUM(COUNT(review_score)) OVER(), 2) AS percentage,
CASE 
WHEN review_score >= 4 THEN 'positif' 
WHEN review_score = 3 THEN 'netral'
 ELSE 'negative' END AS customer_review 
FROM portofolio.olist_order_reviews
GROUP BY customer_review;

-- BUSSINES QUESTION 6
SELECT COUNT(a.review_score) AS number_of_reviews,
CASE 
WHEN b.order_delivered_customer_date > b.order_estimated_delivery_date THEN 'Late'
WHEN b.order_delivered_customer_date <= b.order_estimated_delivery_date THEN 'On Time'
END AS shipping_category,
CASE 
WHEN a.review_score >= 4 THEN 'positif' 
WHEN a.review_score = 3 THEN 'netral'
 ELSE 'negative' END AS customer_review
FROM portofolio.olist_order_reviews AS a JOIN portofolio.olist_orders AS b
ON a.order_id=b.order_id
WHERE b.order_delivered_customer_date IS NOT NULL
AND b.order_estimated_delivery_date IS NOT NULL
GROUP BY 2, 3
ORDER BY 3;

-- BUSSINES QUESTION 7
SELECT COUNT(order_purchase_timestamp) AS number_of_orders, 
TO_CHAR(order_purchase_timestamp, 'YYYY-MM') AS bulan 
FROM portofolio.olist_orders
WHERE order_purchase_timestamp >= '2017-01-01'
AND order_purchase_timestamp < '2018-09-01'
GROUP BY 2
ORDER BY 2;
