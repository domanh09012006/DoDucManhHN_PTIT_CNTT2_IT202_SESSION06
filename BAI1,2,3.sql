create database session06_b1;
use session06_b1;

create table customers(
	customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders(
	order_id int primary key,
    customer_id int not null,
    order_date date,
    status enum('pending','completed', 'cancelled'),
    total_amount DECIMAL(10,2)

);

insert into customers 
values (1,'nguyen van a', 'ha noi'),
(2,'nguyen van b', 'ha noi1'),
(3,'nguyen van c', 'ha noi2'),
(4,'nguyen van d', 'ha noi3'),
(5,'nguyen van e', 'ha noi4');

insert into orders(order_id, customer_id, order_date, status, total_amount)
values (1, 1, '2025-01-02', 'pending',   500000),
(2, 2, '2025-01-03', 'completed', 1200000),
(3, 1, '2025-01-04', 'pending',   800000),
(4, 3, '2025-01-05', 'pending',   300000),
(5, 4, '2025-01-06', 'cancelled', 1500000);


-- Bai 1:
SELECT orders.order_id, customers.full_name, orders.order_date, orders.status
FROM orders JOIN customers ON orders.customer_id = customers.customer_id;

SELECT customers.customer_id, customers.full_name, COUNT(orders.order_id) AS so_don
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.full_name;

-- Bai 2:
SELECT customers.customer_id, customers.full_name, SUM(orders.total_amount) AS tong_tien
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.full_name;

SELECT customers.customer_id, customers.full_name, MAX(orders.total_amount) AS don_hang_cao_nhat
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.full_name;

SELECT customers.customer_id, customers.full_name, SUM(orders.total_amount) AS tong_tien
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.full_name
ORDER BY tong_tien DESC;

-- Bai 3: 
SELECT order_date, SUM(total_amount) AS tong_doanh_thu
FROM orders WHERE status = 'completed'
GROUP BY order_date;

SELECT order_date, COUNT(order_id) AS so_don_hang
FROM orders WHERE status = 'completed'
GROUP BY order_date;

SELECT order_date, SUM(total_amount) AS tong_doanh_thu
FROM orders WHERE status = 'completed'
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;


