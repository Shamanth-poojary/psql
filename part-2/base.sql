CREATE EXTENSION IF NOT EXISTS "pgcrypto";
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    sku TEXT  UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- insertion

INSERT INTO products
(name, category, price, stock, is_active, sku, description)
VALUES
('Wireless Mouse', 'Electronics', 799.00, 120, TRUE, 'ELEC-001', '2.4GHz wireless optical mouse'),
('Mechanical Keyboard', 'Electronics', 3499.00, 65, TRUE, 'ELEC-002', 'RGB mechanical keyboard'),
('USB-C Charger', 'Electronics', 999.00, 200, TRUE, 'ELEC-003', '20W fast charger'),
('Bluetooth Speaker', 'Electronics', 2499.00, 45, TRUE, 'ELEC-004', 'Portable waterproof speaker'),
('Gaming Headset', 'Electronics', 2999.00, 38, TRUE, 'ELEC-005', 'Surround sound gaming headset'),

('Running Shoes', 'Footwear', 4599.00, 70, TRUE, 'FTWR-001', 'Lightweight running shoes'),
('Leather Wallet', 'Accessories', 899.00, 110, TRUE, 'ACCS-001', 'Genuine leather wallet'),
('Backpack', 'Accessories', 1899.00, 55, TRUE, 'ACCS-002', 'Water-resistant laptop backpack'),
('Sunglasses', 'Accessories', 1499.00, 80, TRUE, 'ACCS-003', 'UV protection sunglasses'),
('Sports Cap', 'Accessories', 499.00, 140, TRUE, 'ACCS-004', 'Adjustable cotton cap'),

('Notebook A5', 'Stationery', 199.00, 250, TRUE, 'STAT-001', '200-page ruled notebook'),
('Ball Pen Pack', 'Stationery', 149.00, 300, TRUE, 'STAT-002', 'Pack of 10 blue pens'),
('Desk Organizer', 'Stationery', 699.00, 45, TRUE, 'STAT-003', 'Wooden desk organizer'),
('Highlighter Set', 'Stationery', 299.00, 90, TRUE, 'STAT-004', 'Pack of 5 highlighters'),
('Sticky Notes', 'Stationery', 129.00, 180, TRUE, 'STAT-005', 'Colorful sticky notes'),

('Coffee Mug', 'Kitchen', 349.00, 130, TRUE, 'KIT-001', 'Ceramic coffee mug'),
('Electric Kettle', 'Kitchen', 1599.00, 40, TRUE, 'KIT-002', '1.5L stainless steel kettle'),
('Water Bottle', 'Kitchen', 699.00, 95, TRUE, 'KIT-003', '750ml insulated bottle'),
('Lunch Box', 'Kitchen', 799.00, 85, TRUE, 'KIT-004', 'Leak-proof lunch box'),
('Knife Set', 'Kitchen', 1999.00, 25, FALSE, 'KIT-005', '5-piece kitchen knife set'),

('Yoga Mat', 'Fitness', 999.00, 60, TRUE, 'FIT-001', 'Non-slip yoga mat'),
('Dumbbell 5kg', 'Fitness', 1799.00, 35, TRUE, 'FIT-002', 'Single 5kg dumbbell'),
('Resistance Band', 'Fitness', 499.00, 100, TRUE, 'FIT-003', 'Medium resistance band'),
('Skipping Rope', 'Fitness', 399.00, 120, TRUE, 'FIT-004', 'Adjustable skipping rope'),
('Protein Shaker', 'Fitness', 349.00, 90, TRUE, 'FIT-005', '700ml shaker bottle'),

('Office Chair', 'Furniture', 6499.00, 18, TRUE, 'FURN-001', 'Ergonomic office chair'),
('Study Table', 'Furniture', 7999.00, 12, TRUE, 'FURN-002', 'Engineered wood study table'),
('LED Desk Lamp', 'Furniture', 1299.00, 50, TRUE, 'FURN-003', 'Rechargeable LED desk lamp'),
('Bookshelf', 'Furniture', 5499.00, 10, FALSE, 'FURN-004', '5-tier wooden bookshelf'),
('Bean Bag', 'Furniture', 2999.00, 22, TRUE, 'FURN-005', 'Large comfortable bean bag');

-- data set 2

INSERT INTO products
(name, category, price, stock, sku, description)
VALUES
('Book Stand', 'Stationery', 450.00, 35, 'STAT-006', 'Wooden book stand'),
('Book Cover', 'Stationery', 120.00, 150, 'STAT-007', 'Plastic book cover'),
('Book Light', 'Electronics', 799.00, 40, 'ELEC-006', 'LED reading light'),
('Notebook Pro', 'Stationery', 299.00, 80, 'STAT-008', 'Premium notebook'),
('Notebook Mini', 'Stationery', 149.00, 100, 'STAT-009', 'Pocket notebook'),
('Notebook XL', 'Stationery', 399.00, 50, 'STAT-010', 'Large notebook'),
('Sketch Book', 'Stationery', 249.00, 90, 'STAT-011', 'Artist sketch book'),
('Exercise Book', 'Stationery', 89.00, 250, 'STAT-012', 'School exercise book'),
('MacBook Sleeve', 'Accessories', 999.00, 45, 'ACCS-005', 'Laptop sleeve'),
('Book Shelf Mini', 'Furniture', 2499.00, 12, 'FURN-006', 'Small bookshelf'),

('Gaming Mouse', 'Electronics', 1999.00, 30, 'ELEC-007', 'RGB gaming mouse'),
('Wireless Mouse Pro', 'Electronics', 1499.00, 55, 'ELEC-008', 'Premium wireless mouse'),
('Mouse Pad', 'Electronics', 299.00, 120, 'ELEC-009', 'Large mouse pad'),
('Mouse Bungee', 'Electronics', 699.00, 25, 'ELEC-010', 'Cable management'),

('Smart Watch', 'Electronics', 4999.00, 22, 'ELEC-011', 'Fitness smartwatch'),
('Wall Clock', 'Home', 899.00, 60, 'HOME-001', 'Silent wall clock'),
('Alarm Clock', 'Home', 699.00, 48, 'HOME-002', 'Digital alarm clock'),

('Coffee Maker', 'Kitchen', 5499.00, 18, 'KIT-006', 'Automatic coffee maker'),
('Coffee Beans', 'Groceries', 799.00, 100, 'GROC-001', 'Arabica coffee beans'),
('Coffee Filter', 'Kitchen', 249.00, 75, 'KIT-007', 'Paper coffee filters'),

('Protein Bar', 'Fitness', 99.00, 300, 'FIT-006', 'Chocolate protein bar'),
('Protein Powder', 'Fitness', 2499.00, 35, 'FIT-007', 'Whey protein'),
('Protein Cookies', 'Fitness', 199.00, 140, 'FIT-008', 'High-protein cookies'),

('Water Filter', 'Kitchen', 8999.00, 10, 'KIT-008', 'RO water filter'),
('Water Pump', 'Home', 3499.00, 8, 'HOME-003', 'Electric water pump'),
('Water Can', 'Kitchen', 399.00, 60, 'KIT-009', '20L water can'),

('USB Cable', 'Electronics', 249.00, 180, 'ELEC-012', 'Type-C cable'),
('USB Hub', 'Electronics', 999.00, 42, 'ELEC-013', '4-port USB hub'),
('USB Fan', 'Electronics', 399.00, 65, 'ELEC-014', 'Portable USB fan'),
('USB Lamp', 'Electronics', 349.00, 70, 'ELEC-015', 'Flexible USB lamp');