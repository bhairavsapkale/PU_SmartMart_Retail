CREATE DATABASE IF NOT EXISTS PU_SmartMart;
USE PU_SmartMart;

-- Table 1: Customers
CREATE TABLE Customers (
    CustomerID    INT           AUTO_INCREMENT PRIMARY KEY,
    CustomerName  VARCHAR(100)  NOT NULL,
    City          VARCHAR(50)   NOT NULL,
    Email         VARCHAR(100)  UNIQUE NOT NULL,
    JoinDate      DATE          NOT NULL
    );

-- Table 2: Categories
CREATE TABLE Categories (
    CategoryID    INT           AUTO_INCREMENT PRIMARY KEY,
    CategoryName  VARCHAR(50)   NOT NULL UNIQUE
);

-- Table 3: Products
CREATE TABLE Products (
    ProductID     INT           AUTO_INCREMENT PRIMARY KEY,
    ProductName   VARCHAR(100)  NOT NULL,
    CategoryID    INT           NOT NULL,
    Price         DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    StockQty      INT           NOT NULL DEFAULT 0 CHECK (StockQty >= 0),
    LaunchDate    DATE          NOT NULL,
    CONSTRAINT fk_product_category FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Table 4: Orders
CREATE TABLE Orders (
    OrderID       INT           AUTO_INCREMENT PRIMARY KEY,
    CustomerID    INT           NOT NULL,
    OrderDate     DATE          NOT NULL,
    Channel       ENUM('Online','Retail') NOT NULL,
    TotalAmount   DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_order_customer FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Table 5: OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT           AUTO_INCREMENT PRIMARY KEY,
    OrderID       INT           NOT NULL,
    ProductID     INT           NOT NULL,
    Quantity      INT           NOT NULL CHECK (Quantity > 0),
    UnitPrice     DECIMAL(10,2) NOT NULL CHECK (UnitPrice > 0),
    CONSTRAINT fk_detail_order   FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_detail_product FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- TASK 3: INSERT SAMPLE DATA

-- Categories (6 rows)
INSERT INTO Categories (CategoryName) 
VALUES
('Electronics'),
('Clothing'),
('Groceries'),
('Home & Kitchen'),
('Sports'),
('Books');

-- Customers (20 rows)
INSERT INTO Customers (CustomerName, City, Email, JoinDate) VALUES
('Amit Sharma','Mumbai','amit.sharma1@email.com','2022-01-15'),
('Priya Singh','Delhi','priya.singh@email.com','2022-03-22'),
('Rahul Verma','Bangalore','rahul.verma@email.com','2022-05-10'),
('Neha Gupta','Chennai','neha.gupta@email.com', '2022-06-18'),
('Suresh Kumar','Hyderabad','suresh.kumar@email.com','2022-07-25'),
('Anjali Mehta','Mumbai','anjali.mehta@email.com','2022-08-14'),
('Vikram Nair','Delhi','vikram.nair@email.com','2022-09-30'),
('Pooja Iyer','Bangalore','pooja.iyer@email.com','2022-11-05'),
('Kiran Reddy','Chennai','kiran.reddy@email.com','2023-01-12'),
('Sanjay Patel','Ahmedabad','sanjay.patel@email.com','2023-02-20'),
('Meera Joshi','Pune','meera.joshi@email.com','2023-03-08'),
('Arjun Das','Kolkata','arjun.das@email.com','2023-04-17'),
('Sneha Pillai','Mumbai','sneha.pillai@email.com','2023-05-22'),
('Rohit Bansal','Delhi','rohit.bansal@email.com','2023-06-30'),
('Divya Nair','Bangalore','divya.nair@email.com','2023-07-11'),
('Manoj Tiwari','Lucknow','manoj.tiwari@email.com','2023-08-19'),
('Kavita Rao','Hyderabad','kavita.rao@email.com','2023-09-25'),
('Arun Chandra','Chennai','arun.chandra@email.com','2023-10-14'),
('Deepa Menon','Kochi','deepa.menon@email.com','2023-11-28'),
('Nikhil Saxena','Jaipur','nikhil.saxena@email.com','2024-01-05');


-- Products (15 rows)
INSERT INTO Products (ProductName, CategoryID, Price, StockQty, LaunchDate) VALUES
('Samsung Galaxy S23',    1, 79999.00, 50,  '2023-02-01'),
('Apple AirPods Pro',     1, 24999.00, 30,  '2022-10-15'),
('Sony LED TV 55"',       1, 59999.00,  8,  '2022-06-20'),
('Men\'s Formal Shirt',   2,  1299.00, 200, '2023-01-10'),
('Women\'s Kurti',        2,   899.00, 150, '2023-03-05'),
('Running Shoes',         5,  3499.00,  5,  '2022-11-18'),
('Basmati Rice 5kg',      3,   450.00, 500, '2023-01-01'),
('Olive Oil 1L',          3,   799.00, 120, '2023-02-14'),
('Non-Stick Cookware Set',4,  2999.00,  7,  '2022-09-25'),
('Vacuum Cleaner',        4,  8999.00, 15,  '2023-04-12'),
('Yoga Mat',              5,   999.00, 40,  '2023-05-20'),
('Cricket Bat',           5,  2499.00,  3,  '2022-07-15'),
('Data Structures Book',  6,   599.00, 60,  '2022-08-10'),
('Python Programming',    6,   749.00, 45,  '2023-06-01'),
('Wireless Mouse',        1,  1299.00, 25,  '2023-07-22');

-- Orders (10 rows) — TotalAmount updated via trigger later; set manually here
INSERT INTO Orders (CustomerID, OrderDate, Channel, TotalAmount) VALUES
( 1, '2024-01-10', 'Online',  104998.00),
( 2, '2024-01-15', 'Retail',    5797.00),
( 3, '2024-02-02', 'Online',   27998.00),
( 5, '2024-02-18', 'Online',   10497.00),
( 7, '2024-03-05', 'Retail',    3748.00),
( 4, '2024-03-22', 'Online',   62998.00),
(10, '2024-04-10', 'Retail',    2248.00),
( 8, '2024-04-25', 'Online',   14996.00),
(12, '2024-05-08', 'Retail',    3896.00),
( 1, '2024-05-20', 'Online',   26298.00);

-- OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1,  1, 1, 79999.00),
(1,  2, 1, 24999.00),
(2,  5, 3,   899.00),
(2,  6, 1,  3499.00),
(2, 11, 1,   999.00),
(3,  2, 1, 24999.00),
(3,  1, 1, 79999.00),  
(4,  7, 5,   450.00),
(4,  8, 5,   799.00),
(4, 11, 2,   999.00),
(5, 12, 1,  2499.00),
(5,  6, 1,  3499.00), 
(6,  3, 1, 59999.00),
(6,  2, 1, 24999.00),  
(7, 13, 2,   599.00),
(7, 14, 1,   749.00),
(7, 11, 1,   999.00),  
(8, 15, 2,  1299.00),
(8,  4, 4,  1299.00),
(8, 11, 3,   999.00),
(9,  5, 2,   899.00),
(9, 13, 1,   599.00),
(9, 14, 3,   749.00),
(10, 1, 1, 79999.00),
(10, 9, 1,  2999.00),
(10,10, 1,  8999.00);


-- TASK 4: SQL QUERIES

-- Q1: List all products with category names
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    p.StockQty
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductName;

-- Q2: Find total sales for each product
SELECT 
    p.ProductName,
    SUM(od.Quantity)              AS TotalUnitsSold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;

-- Q3: Top 5 customers by spending
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    SUM(o.TotalAmount) AS TotalSpending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City
ORDER BY TotalSpending DESC
LIMIT 5;

-- Q4: Products with stock less than 10
SELECT 
    ProductID,
    ProductName,
    StockQty,
    Price
FROM Products
WHERE StockQty < 10
ORDER BY StockQty ASC;

-- Q5: Monthly sales revenue
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    COUNT(DISTINCT o.OrderID)         AS TotalOrders,
    SUM(od.Quantity * od.UnitPrice)   AS MonthlyRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
ORDER BY Month;


-- TASK 5: VIEW — sales_summary

CREATE OR REPLACE VIEW sales_summary AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    SUM(od.Quantity)                AS TotalUnitsSold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Products p
JOIN Categories   c  ON p.CategoryID  = c.CategoryID
JOIN OrderDetails od ON p.ProductID   = od.ProductID
GROUP BY p.ProductID, p.ProductName, c.CategoryName;

-- Query the view
SELECT * FROM sales_summary ORDER BY TotalRevenue DESC;


-- TASK 6: INDEX OPTIMIZATION

-- Create index on CategoryID in Products table
CREATE INDEX idx_product_category ON Products(CategoryID);

-- Create index on CustomerID in Orders table (bonus — common join column)
CREATE INDEX idx_order_customer ON Orders(CustomerID);

-- Analyze query performance with EXPLAIN
EXPLAIN 
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.CategoryID = 1;


-- TASK 7: STORED PROCEDURE — Insert a New Order

DELIMITER $$

CREATE PROCEDURE InsertNewOrder (
    IN  p_CustomerID  INT,
    IN  p_OrderDate   DATE,
    IN  p_Channel     ENUM('Online','Retail'),
    IN  p_ProductID   INT,
    IN  p_Quantity    INT,
    OUT p_OrderID     INT,
    OUT p_Message     VARCHAR(200)
)
BEGIN
    DECLARE v_UnitPrice   DECIMAL(10,2);
    DECLARE v_TotalAmount DECIMAL(10,2);
    DECLARE v_Stock       INT;

    -- Get current price and stock
    SELECT Price, StockQty
    INTO   v_UnitPrice, v_Stock
    FROM   Products
    WHERE  ProductID = p_ProductID;

    IF v_Stock < p_Quantity THEN
        SET p_OrderID = NULL;
        SET p_Message = CONCAT('Insufficient stock. Available: ', v_Stock);
    ELSE
        SET v_TotalAmount = v_UnitPrice * p_Quantity;

        START TRANSACTION;

        INSERT INTO Orders (CustomerID, OrderDate, Channel, TotalAmount)
        VALUES (p_CustomerID, p_OrderDate, p_Channel, v_TotalAmount);

        SET p_OrderID = LAST_INSERT_ID();

        INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
        VALUES (p_OrderID, p_ProductID, p_Quantity, v_UnitPrice);

        COMMIT;
        SET p_Message = CONCAT('Order placed successfully. OrderID: ', p_OrderID);
    END IF;
END $$

DELIMITER ;

-- Test the procedure
CALL InsertNewOrder(3, '2024-06-01', 'Online', 11, 2, @newOrderID, @msg);
SELECT @newOrderID AS NewOrderID, @msg AS Message;


-- TASK 8: TRIGGER — Auto-reduce stock on new OrderDetail insert

DELIMITER $$

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET    StockQty = StockQty - NEW.Quantity
    WHERE  ProductID = NEW.ProductID;
END $$

DELIMITER ;

-- Verify trigger effect: check stock before/after inserting an order detail
SELECT ProductID, ProductName, StockQty FROM Products WHERE ProductID = 11;

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES (5, 11, 2, 999.00);   -- OrderID 5 exists

SELECT ProductID, ProductName, StockQty FROM Products WHERE ProductID = 11;


-- TASK 9: TRANSACTIONS — Simulate Order Placement

START TRANSACTION;

    -- Step 1: Insert the order header
    INSERT INTO Orders (CustomerID, OrderDate, Channel, TotalAmount)
    VALUES (6, '2024-06-10', 'Retail', 5998.00);

    SET @txn_order_id = LAST_INSERT_ID();

    -- Step 2: Insert order detail
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
    VALUES (@txn_order_id, 15, 2, 1299.00),
           (@txn_order_id,  4, 2, 1299.00),
           (@txn_order_id, 11, 2,  999.00);

    -- Step 3: Verify stock is not negative (simple check)
    SELECT ProductID, StockQty
    FROM   Products
    WHERE  ProductID IN (15, 4, 11) AND StockQty < 0;

    -- If all looks good → COMMIT; else → ROLLBACK
COMMIT;
-- ROLLBACK;   -- Uncomment this and comment COMMIT to simulate a rollback

SELECT @txn_order_id AS CommittedOrderID;


-- TASK 10: BUSINESS INSIGHTS

-- Insight 1: Which category generates the highest revenue?
SELECT 
    c.CategoryName,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Categories c
JOIN Products     p  ON c.CategoryID  = p.CategoryID
JOIN OrderDetails od ON p.ProductID   = od.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC
LIMIT 1;

-- Insight 2: Which city has the most customers?
SELECT 
    City,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC
LIMIT 1;

-- Insight 3: Which products are rarely sold? (sold fewer than 3 units total OR never sold)
SELECT 
    p.ProductID,
    p.ProductName,
    COALESCE(SUM(od.Quantity), 0) AS TotalUnitsSold
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING TotalUnitsSold < 3
ORDER BY TotalUnitsSold ASC;

-- Insight 4: Which customers should be targeted for loyalty programs?
-- Criteria: customers with ≥ 2 orders OR total spending > 50,000
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    c.Email,
    COUNT(o.OrderID)         AS TotalOrders,
    SUM(o.TotalAmount)       AS TotalSpending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City, c.Email
HAVING TotalOrders >= 2 OR TotalSpending > 50000
ORDER BY TotalSpending DESC;