-- With God's Help

-- Targil B

-- 1
SELECT customers.customer_id 
FROM Customers LEFT OUTER JOIN orders
ON customers.customer_id = ORDERS.customer_id 
WHERE ORDERS.customer_id IS NULL

-- 2
SELECT COUNT(ORDERS.customer_id) AS COUNT_ORDERS,ORDERS.customer_id
FROM Customers LEFT OUTER JOIN orders
ON customers.customer_id = ORDERS.customer_id 
GROUP BY  ORDERS.customer_id 
HAVING COUNT(ORDERS.customer_id) > 10

-- 3
SELECT product_name,unit_price FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)

-- 4
-- We already did this question in Targil A.

-- 5
SELECT COUNT(contact_name),country FROM customers
GROUP BY country
HAVING COUNT(contact_name)>5

-- 6
SELECT customers.customer_id FROM customers
WHERE customers.customer_id NOT IN (
    SELECT orders.customer_id FROM orders
    WHERE EXTRACT(YEAR FROM orders.order_date ) = 1998)

-- 7
SELECT customers.customer_id FROM customers
WHERE customers.customer_id NOT IN (
    SELECT orders.customer_id FROM orders
    WHERE orders.order_date > '01-01-1998')
AND customers.country LIKE 'Germany'

-- 8
SELECT contact_name
FROM customers INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY contact_name
HAVING COUNT(orders.customer_id) = 3

-- 10
SELECT suppliers.supplier_id, company_name, country
FROM suppliers INNER JOIN products
ON suppliers.supplier_id = products.supplier_id
INNER JOIN order_details
ON order_details.product_id = products.product_id
WHERE country LIKE 'USA' 
GROUP BY suppliers.supplier_id
HAVING COUNT(order_details.product_id) > 1