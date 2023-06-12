.open restaurant.db

-- Table 1
DROP TABLE menus;

CREATE TABLE menus (
  menu_id int,
  menu_name text,
  menu_price int
);

INSERT INTO menus VALUES
  (1, 'Tteokbokki', 100),
  (2, 'Bibimbap', 200),
  (3, 'Gimbap', 150),
  (4, 'Japchae', 200),
  (5, 'Gimmari', 150);

.mode column
.header on

SELECT * FROM menus;

-- Table 2
DROP TABLE ingredients;

CREATE TABLE ingredients (
  ingredient_id int,
  ingredient_name text,
  menu_id int,
  amount_serving int
);

INSERT INTO ingredients values
  (1, 'tteok', 1, 350),
  (2, 'gochujang', 1, 50),
  (3, 'eomuk', 1, 150),
  (4, 'rice', 2, 80),
  (5, 'gochujang', 2, 30),
  (6, 'beef', 2, 100),
  (7, 'seaweed', 2, 5),
  (8, 'egg', 2, 50),
  (9, 'rice', 3, 80),
  (10, 'seaweed', 3, 10),
  (11, 'cucumber', 3, 100),
  (12, 'egg', 3, 50),
  (13, 'carrot', 3, 100),
  (14, 'beef', 3, 50),
  (15, 'dangmyeon', 4, 250),
  (16, 'beef', 4, 100),
  (17, 'carrot', 4, 100),
  (18, 'dangmyeon', 5, 150),
  (19, 'seaweed', 5, 10),
  (20, 'potato starch', 5, 150);

.mode column
.header on

SELECT * FROM ingredients;

--Table 3
DROP TABLE customers;

CREATE TABLE customers (
  customer_id int,
  customer_name text,
  customer_district text
);

INSERT INTO customers VALUES 
  (1, 'Plaifah', 'Phasi Charoen'),
  (2, 'Artid', 'Bang Khae'),
  (3, 'Tonkla', 'Taling Chan'),
  (4, 'Ploy', 'Thonburi'),
  (5, 'Paprae', 'Bang Khae');

.mode column
.header on

SELECT * FROM customers;

-- Table 4
DROP TABLE invoices;

CREATE TABLE invoices (
  invoice_id int,
  customer_id int,
  invoice_date text,
  total REAL
);

INSERT INTO invoices VALUES 
  (1, 1, '2023-01-05 11:30:00', 250),
  (2, 3, '2023-01-05 11:45:00', 100),
  (3, 2, '2023-01-05 12:00:00', 500),
  (4, 4, '2023-01-05 13:00:00', 400),
  (5, 3, '2023-01-06 15:00:00', 300),
  (6, 5, '2023-01-06 16:00:00', 400),
  (7, 2, '2023-01-06 16:30:00', 100),
  (8, 2, '2023-01-07 11:00:00', 300),
  (9, 4, '2023-01-07 11:30:00', 450),
  (10, 3, '2023-01-07 12:00:00', 700);

.mode column
.header on

SELECT * FROM invoices;
  
-- Table 5
DROP TABLE deliveryfees;

CREATE TABLE deliveryfees (
  district_id int,
  district_name text,
  fee int
);

INSERT INTO deliveryfees VALUES 
  (1, 'Thonburi', 0),
  (2, 'Phasi Charoen', 10),
  (3, 'Taling Chan', 10),
  (4, 'Bang Khae', 15);

.mode column
.header on

SELECT * FROM deliveryfees;

-- Q1: Prepare Ingredients (5 servings each)
SELECT 
  ing.ingredient_name AS shopping_list,
  SUM(ing.amount_serving*5) || ' grams' AS amount
FROM menus, ingredients AS ing
WHERE menus.menu_id = ing.menu_id
GROUP BY ing.ingredient_name;

-- Q2: Create seaweed lover set
WITH menu_set AS ( 
  SELECT 
    'Seaweed' AS main_ing,
    menus.menu_name AS menu,
    menus.menu_price AS price,
    ing.ingredient_name AS ingredients
  FROM menus JOIN ingredients AS ing 
    ON menus.menu_id = ing.menu_id 
  WHERE LOWER(ingredients) = LOWER(main_ing)
)

SELECT 
  main_ing || ' Lover Set' AS set_name, 
  COUNT(*) AS items, 
  SUM(price) AS price 
FROM menu_set;

-- Q3: Add delivery fees
SELECT 
  inv.invoice_id AS id,
  cus.customer_name AS name,
  inv.invoice_date AS date,
  inv.total + del.fee AS total
FROM invoices AS inv
LEFT JOIN customers AS cus ON inv.customer_id = cus.customer_id
LEFT JOIN deliveryfees AS del ON cus.customer_district = del.district_name;

-- Q4: Calculate total sales on 2023-01-05 (include delivery fees)
SELECT
  STRFTIME('%Y-%m-%d', date) AS selected_date,
  SUM(total) AS sales
FROM (
  SELECT 
  inv.invoice_id AS id,
  cus.customer_name AS name,
  inv.invoice_date AS date,
  inv.total + del.fee AS total
  FROM invoices AS inv
  LEFT JOIN customers AS cus ON inv.customer_id = cus.customer_id
  LEFT JOIN deliveryfees AS del ON cus.customer_district = del.district_name
  GROUP BY date
)
WHERE selected_date = '2023-01-05'; 

-- Q5: Find customers who order more then once and send them ฿50 gift vouchers 
SELECT 
  cus.customer_id AS id,
  cus.customer_name AS name,
  CASE WHEN COUNT(cus.customer_id)>1 THEN 'yes'
  ELSE 'no'
  END AS '฿50 gift voucher'
FROM invoices AS inv 
LEFT JOIN customers AS cus ON inv.customer_id = cus.customer_id
GROUP BY cus.customer_id;
