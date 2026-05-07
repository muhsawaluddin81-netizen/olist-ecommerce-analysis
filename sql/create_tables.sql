CREATE TABLE  portofolio.olist_customers ( 
customer_id VARCHAR PRIMARY KEY, 
customer_unique_id VARCHAR, 
customer_zip_code_prefix INTEGER, 
customer_city TEXT, 
customer_state TEXT);

CREATE TABLE portofolio.olist_geolocation(
geolocation_id SERIAL PRIMARY KEY,
geolocation_zip_code_prefix INTEGER,
geolocation_lat FLOAT,
geolocation_lng FLOAT,
geolocation_city TEXT,
geolocation_state TEXT);


CREATE TABLE portofolio.olist_products( product_id VARCHAR PRIMARY KEY,
product_category_name TEXT,
product_name_lenght INTEGER, 
product_description_lenght INTEGER,
product_photos_qty INTEGER,
product_weight_g FLOAT, 
product_length_cm FLOAT, 
product_height_cm FLOAT, 
product_width_cm FLOAT);


CREATE TABLE portofolio.product_category_name_translation(
product_category_name TEXT,
product_category_name_english TEXT);


CREATE TABLE portofolio.olist_sellers(
seller_id VARCHAR PRIMARY KEY,
seller_zip_code_prefix INTEGER,
seller_city TEXT,
seller_state TEXT);

CREATE TABLE portofolio.olist_orders( 
order_id VARCHAR PRIMARY KEY, 
customer_id VARCHAR,
 order_status TEXT, 
order_purchase_timestamp TIMESTAMP, 
order_approved_at TIMESTAMP,
 order_delivered_carrier_date TIMESTAMP,
 order_delivered_customer_date TIMESTAMP,
 order_estimated_delivery_date TIMESTAMP);

CREATE TABLE portofolio.olist_order_items(
order_id VARCHAR,
order_item_id INTEGER,
product_id VARCHAR,
seller_id VARCHAR,
shipping_limit_date TIMESTAMP,
price NUMERIC,
freight_value NUMERIC,
PRIMARY KEY (order_id, order_item_id));

 
CREATE TABLE portofolio.olist_order_payments( 
order_id VARCHAR , 
payment_sequential INTEGER,
payment_type TEXT, 
payment_installments INTEGER, 
payment_value NUMERIC, 
PRIMARY KEY (order_id,payment_sequential ));


CREATE TABLE portofolio.olist_order_reviews( 
review_id VARCHAR, 
order_id VARCHAR, 
review_score INTEGER, 
review_comment_title VARCHAR,
review_comment_message VARCHAR,
review_creation_date TIMESTAMP,
review_answer_timestamp TIMESTAMP,
PRIMARY KEY (review_id,order_id));
