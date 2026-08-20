-- ============================================================
-- ADVANCED DBMS PRACTICE DATASET
-- ============================================================

BEGIN;

-- ============================================================
-- 1. CONVERT PRODUCTS TO A RELATIONAL CATEGORY MODEL
-- ============================================================

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL UNIQUE,
    description TEXT
);

INSERT INTO categories (category_name, description)
SELECT DISTINCT
    category,
    category || ' products'
FROM products
ORDER BY category;

ALTER TABLE products
ADD COLUMN category_id INT;

UPDATE products p
SET category_id = c.category_id
FROM categories c
WHERE p.category = c.category_name;

ALTER TABLE products
ALTER COLUMN category_id SET NOT NULL;

ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (category_id)
REFERENCES categories(category_id)
ON DELETE RESTRICT;

ALTER TABLE products
DROP COLUMN category;

-- ============================================================
-- 2. SUPPLIERS
-- ============================================================

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name TEXT NOT NULL UNIQUE,
    email TEXT UNIQUE,
    city TEXT NOT NULL,
    rating NUMERIC(3,2) CHECK (rating BETWEEN 0 AND 5)
);

INSERT INTO suppliers (supplier_name, email, city, rating) VALUES
('TechSource India', 'techsource@example.com', 'Bengaluru', 4.60),
('Prime Electronics', 'prime@example.com', 'Mumbai', 4.30),
('Urban Supplies', 'urban@example.com', 'Delhi', 4.10),
('HomeNeeds Pvt Ltd', 'homeneeds@example.com', 'Chennai', 3.90),
('FitGear India', 'fitgear@example.com', 'Hyderabad', 4.50),
('KitchenKart Suppliers', 'kitchenkart@example.com', 'Pune', 4.20),
('OfficePro Distributors', 'officepro@example.com', 'Bengaluru', 4.00),
('Global Goods', 'globalgoods@example.com', 'Kolkata', 3.80),
('Smart Retail Supply', 'smartretail@example.com', 'Ahmedabad', 4.40),
('ValueHub', 'valuehub@example.com', 'Mysuru', 3.70);

-- ============================================================
-- 3. MANY-TO-MANY: PRODUCTS <-> SUPPLIERS
-- ============================================================

CREATE TABLE product_suppliers (
    product_id UUID NOT NULL,
    supplier_id INT NOT NULL,
    supplier_price NUMERIC(10,2) NOT NULL CHECK (supplier_price >= 0),
    lead_time_days INT NOT NULL CHECK (lead_time_days >= 0),
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE,
    FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
        ON DELETE CASCADE
);

INSERT INTO product_suppliers
(product_id, supplier_id, supplier_price, lead_time_days)
SELECT p.id, s.supplier_id,
       ROUND(p.price * factor, 2),
       lead_time
FROM (
    VALUES
    ('Wireless Mouse', 1, 0.72, 4),
    ('Mechanical Keyboard', 1, 0.70, 5),
    ('Gaming Mouse', 2, 0.68, 6),
    ('Wireless Mouse Pro', 2, 0.71, 5),
    ('USB-C Charger', 2, 0.69, 4),
    ('Bluetooth Speaker', 3, 0.73, 7),
    ('Running Shoes', 5, 0.65, 8),
    ('Yoga Mat', 5, 0.62, 5),
    ('Dumbbell 5kg', 5, 0.70, 6),
    ('Office Chair', 7, 0.67, 10),
    ('Study Table', 7, 0.70, 12),
    ('Bookshelf', 4, 0.68, 14),
    ('Coffee Maker', 6, 0.66, 7),
    ('Electric Kettle', 6, 0.69, 5),
    ('Water Filter', 6, 0.74, 9),
    ('Smart Watch', 9, 0.70, 6),
    ('Backpack', 3, 0.64, 5),
    ('Protein Powder', 5, 0.75, 6),
    ('Notebook A5', 7, 0.55, 4),
    ('Desk Organizer', 7, 0.60, 5),
    ('Wall Clock', 4, 0.68, 7),
    ('Water Pump', 4, 0.71, 10),
    ('USB Hub', 2, 0.70, 4),
    ('USB Cable', 2, 0.62, 3),
    ('Gaming Mouse', 9, 0.72, 5),
    ('Office Chair', 8, 0.69, 9),
    ('Coffee Maker', 8, 0.71, 8),
    ('Smart Watch', 1, 0.73, 6),
    ('MacBook Sleeve', 3, 0.66, 5),
    ('Water Bottle', 5, 0.60, 5)
) AS x(product_name, supplier_id, factor, lead_time)
JOIN products p ON p.name = x.product_name
JOIN suppliers s ON s.supplier_id = x.supplier_id;

-- ============================================================
-- 4. CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers (full_name, email, phone) VALUES
('Aarav Sharma', 'aarav@example.com', '9000000001'),
('Ananya Rao', 'ananya@example.com', '9000000002'),
('Rohan Shetty', 'rohan@example.com', '9000000003'),
('Priya Nair', 'priya@example.com', '9000000004'),
('Vikram Singh', 'vikram@example.com', '9000000005'),
('Sneha Kulkarni', 'sneha@example.com', '9000000006'),
('Rahul Verma', 'rahul@example.com', '9000000007'),
('Kavya Menon', 'kavya@example.com', '9000000008'),
('Arjun Kumar', 'arjun@example.com', '9000000009'),
('Meera Joshi', 'meera@example.com', '9000000010'),
('Aditya Patil', 'aditya@example.com', '9000000011'),
('Nisha Bhat', 'nisha@example.com', '9000000012'),
('Sanjay Rao', 'sanjay@example.com', '9000000013'),
('Isha Shah', 'isha@example.com', '9000000014'),
('Kiran Das', 'kiran@example.com', '9000000015');

-- ============================================================
-- 5. ONE-TO-MANY: CUSTOMERS <-> ADDRESSES
-- ============================================================

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id)
        ON DELETE CASCADE,
    address_type TEXT NOT NULL
        CHECK (address_type IN ('HOME', 'WORK', 'OTHER')),
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    pincode TEXT NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO addresses
(customer_id, address_type, city, state, pincode, is_default)
VALUES
(1, 'HOME', 'Bengaluru', 'Karnataka', '560001', TRUE),
(1, 'WORK', 'Bengaluru', 'Karnataka', '560034', FALSE),
(2, 'HOME', 'Mysuru', 'Karnataka', '570001', TRUE),
(3, 'HOME', 'Mangaluru', 'Karnataka', '575001', TRUE),
(4, 'HOME', 'Kochi', 'Kerala', '682001', TRUE),
(5, 'HOME', 'Delhi', 'Delhi', '110001', TRUE),
(6, 'HOME', 'Pune', 'Maharashtra', '411001', TRUE),
(7, 'HOME', 'Hyderabad', 'Telangana', '500001', TRUE),
(8, 'HOME', 'Chennai', 'Tamil Nadu', '600001', TRUE),
(9, 'HOME', 'Bengaluru', 'Karnataka', '560040', TRUE),
(10, 'HOME', 'Mumbai', 'Maharashtra', '400001', TRUE),
(11, 'HOME', 'Hubballi', 'Karnataka', '580001', TRUE),
(12, 'HOME', 'Udupi', 'Karnataka', '576101', TRUE),
(13, 'HOME', 'Kolkata', 'West Bengal', '700001', TRUE),
(14, 'HOME', 'Ahmedabad', 'Gujarat', '380001', TRUE),
(15, 'HOME', 'Mysuru', 'Karnataka', '570002', TRUE);

-- ============================================================
-- 6. EMPLOYEES + SELF REFERENCING FOREIGN KEY
-- ============================================================

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name TEXT NOT NULL,
    manager_id INT REFERENCES employees(employee_id)
        ON DELETE SET NULL,
    department TEXT NOT NULL,
    salary NUMERIC(10,2) NOT NULL CHECK (salary >= 0)
);

INSERT INTO employees
(employee_name, manager_id, department, salary)
VALUES
('Rajesh Kumar', NULL, 'Sales', 85000),
('Divya Rao', 1, 'Sales', 62000),
('Manoj Shetty', 1, 'Sales', 58000),
('Neha Sharma', NULL, 'Operations', 90000),
('Amit Nair', 4, 'Operations', 64000),
('Pooja Singh', 4, 'Operations', 61000),
('Suresh Patil', NULL, 'Support', 78000),
('Ritika Shah', 7, 'Support', 56000),
('Karthik Rao', 7, 'Support', 59000);

-- ============================================================
-- 7. ORDERS
-- ============================================================

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id)
        ON DELETE RESTRICT,
    employee_id INT REFERENCES employees(employee_id)
        ON DELETE SET NULL,
    order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL CHECK (
        status IN ('PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED')
    )
);

INSERT INTO orders (customer_id, employee_id, order_date, status) VALUES
(1, 2, '2026-01-05 10:30:00+05:30', 'DELIVERED'),
(2, 2, '2026-01-08 14:00:00+05:30', 'DELIVERED'),
(3, 3, '2026-01-12 09:20:00+05:30', 'SHIPPED'),
(4, 5, '2026-01-18 16:40:00+05:30', 'DELIVERED'),
(5, 5, '2026-01-21 11:10:00+05:30', 'CANCELLED'),
(6, 6, '2026-02-02 13:00:00+05:30', 'DELIVERED'),
(7, 2, '2026-02-05 15:25:00+05:30', 'CONFIRMED'),
(8, 3, '2026-02-09 10:45:00+05:30', 'DELIVERED'),
(9, 5, '2026-02-14 12:30:00+05:30', 'SHIPPED'),
(10, 6, '2026-02-18 18:10:00+05:30', 'DELIVERED'),
(11, 8, '2026-03-01 09:00:00+05:30', 'DELIVERED'),
(12, 8, '2026-03-04 17:20:00+05:30', 'PENDING'),
(13, 9, '2026-03-10 11:40:00+05:30', 'DELIVERED'),
(14, 2, '2026-03-15 14:15:00+05:30', 'CONFIRMED'),
(15, 3, '2026-03-18 16:00:00+05:30', 'DELIVERED'),
(1, 5, '2026-03-20 10:10:00+05:30', 'DELIVERED'),
(4, 6, '2026-03-22 13:35:00+05:30', 'CANCELLED'),
(7, 8, '2026-03-25 15:00:00+05:30', 'SHIPPED'),
(9, 9, '2026-03-28 11:30:00+05:30', 'DELIVERED'),
(12, 2, '2026-04-01 19:00:00+05:30', 'PENDING');

-- ============================================================
-- 8. ORDER ITEMS
-- ============================================================

CREATE TABLE order_items (
    order_id INT NOT NULL REFERENCES orders(order_id)
        ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id)
        ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    discount NUMERIC(5,2) NOT NULL DEFAULT 0
        CHECK (discount BETWEEN 0 AND 100),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO order_items
(order_id, product_id, quantity, unit_price, discount)
SELECT x.order_id, p.id, x.quantity, p.price, x.discount
FROM (
    VALUES
    (1, 'Wireless Mouse', 2, 5),
    (1, 'Mechanical Keyboard', 1, 10),
    (2, 'Running Shoes', 1, 5),
    (2, 'Sports Cap', 2, 0),
    (3, 'Gaming Mouse', 1, 5),
    (3, 'Mouse Pad', 2, 0),
    (4, 'Office Chair', 1, 8),
    (4, 'LED Desk Lamp', 2, 0),
    (5, 'Study Table', 1, 5),
    (6, 'Yoga Mat', 2, 0),
    (6, 'Dumbbell 5kg', 1, 5),
    (7, 'Smart Watch', 1, 10),
    (8, 'Coffee Maker', 1, 5),
    (8, 'Coffee Mug', 3, 0),
    (9, 'Protein Powder', 2, 8),
    (9, 'Protein Shaker', 1, 0),
    (10, 'Water Filter', 1, 10),
    (11, 'USB Hub', 2, 0),
    (11, 'USB-C Charger', 2, 5),
    (12, 'Backpack', 1, 0),
    (13, 'Bookshelf', 1, 5),
    (13, 'Book Stand', 2, 0),
    (14, 'Bluetooth Speaker', 1, 5),
    (14, 'Sunglasses', 1, 0),
    (15, 'Electric Kettle', 1, 5),
    (15, 'Water Bottle', 2, 0),
    (16, 'Mechanical Keyboard', 1, 5),
    (16, 'Gaming Headset', 1, 10),
    (17, 'Office Chair', 1, 5),
    (18, 'Resistance Band', 3, 0),
    (18, 'Skipping Rope', 2, 0),
    (19, 'Wireless Mouse Pro', 1, 5),
    (19, 'Smart Watch', 1, 5),
    (20, 'Notebook Pro', 5, 0),
    (20, 'Desk Organizer', 1, 0)
) AS x(order_id, product_name, quantity, discount)
JOIN products p ON p.name = x.product_name;

-- ============================================================
-- 9. PAYMENTS - ONE-TO-ONE WITH ORDERS
-- ============================================================

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL UNIQUE REFERENCES orders(order_id)
        ON DELETE CASCADE,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    payment_method TEXT NOT NULL CHECK (
        payment_method IN ('UPI', 'CARD', 'COD', 'NET_BANKING', 'WALLET')
    ),
    payment_status TEXT NOT NULL CHECK (
        payment_status IN ('PENDING', 'PAID', 'FAILED', 'REFUNDED')
    ),
    paid_at TIMESTAMPTZ
);

INSERT INTO payments
(order_id, amount, payment_method, payment_status, paid_at)
SELECT
    o.order_id,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100)), 2),
    (ARRAY['UPI','CARD','COD','NET_BANKING','WALLET'])[1 + ((o.order_id - 1) % 5)],
    CASE
        WHEN o.status = 'CANCELLED' THEN 'REFUNDED'
        WHEN o.status = 'PENDING' THEN 'PENDING'
        ELSE 'PAID'
    END,
    CASE
        WHEN o.status IN ('DELIVERED','SHIPPED','CONFIRMED') THEN o.order_date + INTERVAL '1 hour'
        ELSE NULL
    END
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.status, o.order_date;

-- ============================================================
-- 10. REVIEWS
-- ============================================================

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id)
        ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id)
        ON DELETE CASCADE,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    reviewed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (customer_id, product_id)
);

INSERT INTO reviews
(customer_id, product_id, rating, review_text)
SELECT x.customer_id, p.id, x.rating, x.review_text
FROM (
    VALUES
    (1, 'Wireless Mouse', 5, 'Smooth and reliable'),
    (1, 'Mechanical Keyboard', 4, 'Good keyboard'),
    (2, 'Running Shoes', 5, 'Very comfortable'),
    (3, 'Gaming Mouse', 4, 'Good for gaming'),
    (4, 'Office Chair', 5, 'Excellent chair'),
    (5, 'Study Table', 4, 'Sturdy table'),
    (6, 'Yoga Mat', 5, 'Good grip'),
    (7, 'Smart Watch', 4, 'Useful features'),
    (8, 'Coffee Maker', 5, 'Makes good coffee'),
    (9, 'Protein Powder', 4, 'Good taste'),
    (10, 'Water Filter', 5, 'Works well'),
    (11, 'USB Hub', 4, 'Convenient'),
    (12, 'Backpack', 5, 'Spacious'),
    (13, 'Bookshelf', 4, 'Easy to assemble'),
    (14, 'Bluetooth Speaker', 3, 'Average sound'),
    (15, 'Electric Kettle', 5, 'Heats quickly'),
    (2, 'Coffee Mug', 4, 'Nice mug'),
    (3, 'Mouse Pad', 4, 'Good size'),
    (6, 'Dumbbell 5kg', 5, 'Solid build'),
    (9, 'Protein Shaker', 4, 'Does the job')
) AS x(customer_id, product_name, rating, review_text)
JOIN products p ON p.name = x.product_name;

-- ============================================================
-- 11. INDEXES
-- ============================================================

CREATE INDEX idx_products_category_id
    ON products(category_id);

CREATE INDEX idx_product_suppliers_supplier_id
    ON product_suppliers(supplier_id);

CREATE INDEX idx_orders_customer_id
    ON orders(customer_id);

CREATE INDEX idx_orders_employee_id
    ON orders(employee_id);

CREATE INDEX idx_orders_order_date
    ON orders(order_date);

CREATE INDEX idx_order_items_product_id
    ON order_items(product_id);

CREATE INDEX idx_reviews_product_id
    ON reviews(product_id);

COMMIT;

-- ============================================================
-- RELATIONSHIP SUMMARY
--
-- categories 1 ---- N products
-- products N ---- N suppliers
-- customers 1 ---- N addresses
-- customers 1 ---- N orders
-- employees 1 ---- N orders
-- employees 1 ---- N employees (self-reference)
-- orders 1 ---- N order_items
-- products 1 ---- N order_items
-- orders 1 ---- 1 payment
-- customers N ---- N products through reviews
-- =========================================================