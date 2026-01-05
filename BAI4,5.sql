use session06_b1;

create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into products values
(1, 'ao', 200000),
(2, 'quan', 500000),
(3, 'giay ', 1200000),
(4, 'mu', 150000),
(5, 'balo', 800000);

insert into order_items values
(1, 1, 3),
(1, 2, 1),
(2, 3, 2),
(3, 1, 5),
(4, 5, 1),
(5, 3, 1);

SELECT products.product_id, products.product_name, SUM(order_items.quantity) AS tong_so_luong
FROM products
JOIN order_items ON products.product_id = order_items.product_id
GROUP BY products.product_id, products.product_name;

SELECT products.product_id, products.product_name, SUM(order_items.quantity * products.price) AS doanh_thu
FROM products
JOIN order_items ON products.product_id = order_items.product_id
GROUP BY products.product_id, products.product_name;

SELECT products.product_id, products.product_name, SUM(order_items.quantity * products.price) AS doanh_thu
FROM products
JOIN order_items ON products.product_id = order_items.product_id
GROUP BY products.product_id, products.product_name
HAVING SUM(order_items.quantity * products.price) > 5000000;

-- Bài 5: 
select customers.customer_id, customers.full_name, 
count(orders.order_id) as tong_don, 
sum(orders.total_amount) as tong_tien,
avg(orders.total_amount) as trung_binh

from customers
join orders on customers.customer_id = orders.customer_id
group by customers.customer_id, customers.full_name
having count(orders.order_id) >= 3 and sum(orders.total_amount) > 10000000
order by tong_tien desc;

