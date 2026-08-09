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
