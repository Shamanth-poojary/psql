### Question

From the `products` table, display only the `name` and `price` columns for all products.

### Query

```sql
select name,price from products;
```

### Output

```text
       name         |  price
---------------------+---------
 Wireless Mouse      |  799.00
 Mechanical Keyboard | 3499.00
 USB-C Charger       |  999.00
 Bluetooth Speaker   | 2499.00
 Gaming Headset      | 2999.00
 Running Shoes       | 4599.00
 Leather Wallet      |  899.00
 Backpack            | 1899.00
 Sunglasses          | 1499.00
 Sports Cap          |  499.00
 Notebook A5         |  199.00
 Ball Pen Pack       |  149.00
 Desk Organizer      |  699.00
 Highlighter Set     |  299.00
 Sticky Notes        |  129.00
 Coffee Mug          |  349.00
 Electric Kettle     | 1599.00
 Water Bottle        |  699.00
-- More  --
```

### Question

From the `products` table, display all products whose price is greater than 500.

### Query

```sql
select name,price from products where (price>500);
```

### Output

```text
       name         |  price
---------------------+---------
 Wireless Mouse      |  799.00
 Mechanical Keyboard | 3499.00
 USB-C Charger       |  999.00
 Bluetooth Speaker   | 2499.00
 Gaming Headset      | 2999.00
 Running Shoes       | 4599.00
 Leather Wallet      |  899.00
 Backpack            | 1899.00
 Sunglasses          | 1499.00
 Desk Organizer      |  699.00
 Electric Kettle     | 1599.00
 Water Bottle        |  699.00
 Lunch Box           |  799.00
 Knife Set           | 1999.00
 Yoga Mat            |  999.00
 Dumbbell 5kg        | 1799.00
 Office Chair        | 6499.00
 Study Table         | 7999.00
-- More  --
```

### Question

From the `products` table, display the `name` and `price` of products whose price is greater than 500, sorted from the most expensive product to the least expensive.

### Query

```sql
select name,price from products where (price>500) order by price desc;
```

### Output

```text
       name         |  price
---------------------+---------
 Water Filter        | 8999.00
 Study Table         | 7999.00
 Office Chair        | 6499.00
 Bookshelf           | 5499.00
 Coffee Maker        | 5499.00
 Smart Watch         | 4999.00
 Running Shoes       | 4599.00
 Water Pump          | 3499.00
 Mechanical Keyboard | 3499.00
 Gaming Headset      | 2999.00
 Bean Bag            | 2999.00
 Protein Powder      | 2499.00
 Book Shelf Mini     | 2499.00
 Bluetooth Speaker   | 2499.00
 Knife Set           | 1999.00
 Gaming Mouse        | 1999.00
 Backpack            | 1899.00
 Dumbbell 5kg        | 1799.00
-- More  --
```

### Question

From the `products` table, display the `name`, `price`, and `category` of products that belong to either the `Electronics` or `Furniture` category and have a price greater than 500. Sort the results by price from highest to lowest.

### Query

```sql
select name,price,category from products where category in ('Electronics','Furniture') and price>500 order by price desc;
```

### Output

```text
        name         |  price  |  category
---------------------+---------+-------------
 Study Table         | 7999.00 | Furniture
 Office Chair        | 6499.00 | Furniture
 Bookshelf           | 5499.00 | Furniture
 Smart Watch         | 4999.00 | Electronics
 Mechanical Keyboard | 3499.00 | Electronics
 Gaming Headset      | 2999.00 | Electronics
 Bean Bag            | 2999.00 | Furniture
 Book Shelf Mini     | 2499.00 | Furniture
 Bluetooth Speaker   | 2499.00 | Electronics
 Gaming Mouse        | 1999.00 | Electronics
 Wireless Mouse Pro  | 1499.00 | Electronics
 LED Desk Lamp       | 1299.00 | Furniture
 USB Hub             |  999.00 | Electronics
 USB-C Charger       |  999.00 | Electronics
 Book Light          |  799.00 | Electronics
 Wireless Mouse      |  799.00 | Electronics
 Mouse Bungee        |  699.00 | Electronics
(17 rows)
-- More  --
```

### Question

Using the `products` table, find the number of products in each category. Display the category and the total number of products, sorted from the category with the most products to the least.

### Query

```sql
select category,count(*) as number_of_products from products  group by category order by number_of_products desc;
```

### Output

```text
  category   | number_of_products
-------------+--------------------
 Electronics |                 15
 Stationery  |                 12
 Kitchen     |                  9
 Fitness     |                  8
 Furniture   |                  6
 Accessories |                  5
 Home        |                  3
 Footwear    |                  1
 Groceries   |                  1
```

### Question

Find the average price of products in each category. Display the category and average price, and show only categories whose average price is greater than 500.

### Query

```sql
select category,round(avg(price),2) as category_product_average from products group by category having(avg(price)>500);
```

### Output

```text
  category   | category_product_average
-------------+--------------------------
 Groceries   |                   799.00
 Fitness     |                   855.25
 Accessories |                  1159.00
 Furniture   |                  4465.67
 Footwear    |                  4599.00
 Electronics |                  1539.00
 Home        |                  1699.00
 Kitchen     |                  2287.89
```

### Question

Find the minimum, maximum, and average price of products in each category. Display the category along with all three values, rounded to 2 decimal places. Show only categories whose average price is greater than 500.

### Query

```sql
select category,max(price) as maximum,min(price) as minimum,round(avg(price),2) as category_product_average from products group by category having(avg(price)>500);
```

### Output

```text
  category   | maximum | minimum | category_product_average
-------------+---------+---------+--------------------------
 Groceries   |  799.00 |  799.00 |                   799.00
 Fitness     | 2499.00 |   99.00 |                   855.25
 Accessories | 1899.00 |  499.00 |                  1159.00
 Furniture   | 7999.00 | 1299.00 |                  4465.67
 Footwear    | 4599.00 | 4599.00 |                  4599.00
 Electronics | 4999.00 |  249.00 |                  1539.00
 Home        | 3499.00 |  699.00 |                  1699.00
 Kitchen     | 8999.00 |  249.00 |                  2287.89
(8 rows)
```

### Question

Find the total number of products and the average price for each category. Display only categories that contain more than 3 products, and sort the results by the number of products in descending order.

### Query

```sql
 select category,count(*) as no_of_products,round(avg(price),2) as average_of_products from products group by category having count(*)>3 order by(no_of_products) desc;
```

### Output

```text
  category   | no_of_products | average_of_products
-------------+----------------+---------------------
 Electronics |             15 |             1539.00
 Stationery  |             12 |              269.17
 Kitchen     |              9 |             2287.89
 Fitness     |              8 |              855.25
 Furniture   |              6 |             4465.67
 Accessories |              5 |             1159.00
(6 rows)
```

### Question

From the `products` table, find the total value of products in each category, where only products with a price greater than 300 are considered. Display the category and total value, and show only categories whose total value exceeds 3000.

### Query

```sql
select category,sum(price) as total_sum from products where price>300 group by category having sum(price)>3000;
```

### Output

```text
  category   | total_sum
-------------+-----------
 Fitness     |   6544.00
 Accessories |   5795.00
 Furniture   |  26794.00
 Footwear    |   4599.00
 Electronics |  22537.00
 Home        |   5097.00
 Kitchen     |  20342.00
```

### Question

For each category, calculate the average price and total inventory value (`price × stock_quantity`). Consider only products with a stock quantity greater than 10. Display categories whose total inventory value exceeds 10,000, sorted by total inventory value from highest to lowest.

### Query

```sql
 select category,sum(price*stock)as total_sum,round(avg(price),2) as average_price from products where stock>10 group by category having sum(price*stock)>10000 order by total_sum desc;
```

### Output

```text
  category   | total_sum  | average_price
-------------+------------+---------------
 Electronics | 1229363.00 |       1539.00
 Accessories |  438070.00 |       1159.00
 Kitchen     |  435222.00 |       1449.00
 Fitness     |  397120.00 |        855.25
 Furniture   |  373886.00 |       4259.00
 Footwear    |  321930.00 |       4599.00
 Stationery  |  313215.00 |        269.17
 Home        |   87492.00 |        799.00
 Groceries   |   79900.00 |        799.00
```

### Question

Find the top 3 categories based on their **total inventory value** (`price × stock`).

For each category, display:

- category
- number of products
- total inventory value
- average product price

Consider only products with `stock > 5` and `price > 500`.

Only include categories whose total inventory value is greater than 20,000. Sort by total inventory value from highest to lowest.

### Query

```sql
select category,count(*) as no_of_products,sum(price*stock) as total_inventory_value,round(avg(price),2) as average_product_price from products where stock>5 and price>500 group by categ
ory having sum(price*stock)>20000 order by total_inventory_value desc limit 3;
```

### Output

```text
 category   | no_of_products | total_inventory_value | average_product_price
-------------+----------------+-----------------------+-----------------------
 Electronics |             11 |            1093318.00 |               1980.82
 Kitchen     |              6 |             437227.00 |               3265.67
 Furniture   |              6 |             428876.00 |               4465.67
(3 rows)
```

### Question

Display each customer's name, their order ID, order status, and order date.

Sort the results by order date from newest to oldest.

### Query

```sql
select customers.full_name,orders.order_id,orders.status,orders.order_date from customers join orders on customers.
customer_id=orders.customer_id order by orders.order_date desc;
```

### Output

```text
 full_name    | order_id |  status   |        order_date
----------------+----------+-----------+---------------------------
 Nisha Bhat     |       20 | PENDING   | 2026-04-01 19:00:00+05:30
 Arjun Kumar    |       19 | DELIVERED | 2026-03-28 11:30:00+05:30
 Rahul Verma    |       18 | SHIPPED   | 2026-03-25 15:00:00+05:30
 Priya Nair     |       17 | CANCELLED | 2026-03-22 13:35:00+05:30
 Aarav Sharma   |       16 | DELIVERED | 2026-03-20 10:10:00+05:30
 Kiran Das      |       15 | DELIVERED | 2026-03-18 16:00:00+05:30
 Isha Shah      |       14 | CONFIRMED | 2026-03-15 14:15:00+05:30
 Sanjay Rao     |       13 | DELIVERED | 2026-03-10 11:40:00+05:30
 Nisha Bhat     |       12 | PENDING   | 2026-03-04 17:20:00+05:30
 Aditya Patil   |       11 | DELIVERED | 2026-03-01 09:00:00+05:30
 Meera Joshi    |       10 | DELIVERED | 2026-02-18 18:10:00+05:30
 Arjun Kumar    |        9 | SHIPPED   | 2026-02-14 12:30:00+05:30
 Kavya Menon    |        8 | DELIVERED | 2026-02-09 10:45:00+05:30
 Rahul Verma    |        7 | CONFIRMED | 2026-02-05 15:25:00+05:30
 Sneha Kulkarni |        6 | DELIVERED | 2026-02-02 13:00:00+05:30
 Vikram Singh   |        5 | CANCELLED | 2026-01-21 11:10:00+05:30
 Priya Nair     |        4 | DELIVERED | 2026-01-18 16:40:00+05:30
 Rohan Shetty   |        3 | SHIPPED   | 2026-01-12 09:20:00+05:30
 Ananya Rao     |        2 | DELIVERED | 2026-01-08 14:00:00+05:30
 Aarav Sharma   |        1 | DELIVERED | 2026-01-05 10:30:00+05:30
(20 rows)
```
