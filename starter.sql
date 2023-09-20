-- With God's Help

-- Targil A --

-- 1 --
SELECT Employees.first_name AS Employee_Name , COUNT(Orders.employee_id)
FROM Employees INNER JOIN Orders
ON employees.employee_id = orders.employee_id
GROUP BY  employees.first_name

-- 2 --
SELECT  SUM(order_details.quantity) AS Total_Sales,categories.category_name
FROM Products INNER JOIN order_details 
ON Products.product_id = order_details.product_id 
INNER JOIN categories
ON Products.category_id = categories.category_id
group by  products.category_id, categories.category_name
ORDER BY SUM(order_details.quantity)

-- 3 --
SELECT customers.customer_id,AVG(TotalMoney) as AVG_TOTAL
FROM customers INNER JOIN (
SELECT orders.customer_id,SUM(od.unit_price*od.quantity*(1-od.discount)) as TotalMoney
FROM order_details od INNER JOIN orders
ON orders.order_id = od.order_id
GROUP BY  orders.order_id
) subQuery ON customers.customer_id = subQuery.customer_id
GROUP BY customers.customer_id
ORDER BY AVG_TOTAL DESC

-- 4 --
SELECT SUM((order_details.unit_price*quantity)*(1-order_details.discount)) as SUM_TOTAL,  customers.customer_id 
FROM order_details INNER JOIN orders
ON orders.order_id =  order_details.order_id
INNER JOIN customers
ON  customers.customer_id = Orders.customer_id
GROUP BY customers.customer_id
order by SUM_TOTAL DESC LIMIT 10

-- 5 --
SELECT EXTRACT(YEAR FROM orders.order_date) AS year, SUM(order_details.unit_price*quantity*(1-discount)) AS Monthly_Total_Sales,EXTRACT(MONTH FROM orders.order_date) AS Month
FROM Orders INNER JOIN order_details
ON Order_details.order_id = orders.order_id
GROUP BY year,Month
ORDER BY Month DESC

-- 6 --
SELECT products.units_in_stock AS UIS, products.product_name
FROM products
WHERE products.units_in_stock < 10
ORDER BY products.units_in_stock 

-- 7 --
SELECT MAX(order_details.unit_price*quantity*(1-discount)) AS MAXIMUM,
customers.customer_id
FROM Orders INNER JOIN customers
On orders.customer_id = customers.customer_id
INNER JOIN order_details
on order_details.order_id = orders.order_id
GROUP BY customers.customer_id
ORDER BY MAXIMUM DESC LIMIT 1

-- 8 --
SELECT SUM(order_details.unit_price*quantity*(1-discount)) AS TOTAL_SUM, orders.ship_country
FROM Orders INNER JOIN order_details
ON Orders.order_id = order_details.order_id
GROUP BY  orders.ship_country 
ORDER BY TOTAL_SUM DESC

-- 9 --
SELECT COUNT(Orders.order_id) AS COUNT_SHIP,Orders.ship_via as SHIP_ID
FROM orders INNER JOIN shippers
ON ORDERS.ship_via = shippers.shipper_id
GROUP BY Orders.ship_via
ORDER BY COUNT_SHIP DESC LIMIT 1

-- 10 --
SELECT Products.product_name, order_details.product_id
FROM products LEFT OUTER JOIN order_details
ON Products.product_id = order_details.product_id
WHERE order_details.product_id IS NULL
GROUP BY Products.product_name,order_details.product_id