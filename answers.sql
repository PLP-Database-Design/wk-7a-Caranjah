-- question 1

-- Original table violates 1NF because Products column contains multiple values
-- Solution: Split the multi-valued Products column into separate rows

-- Step 1: Create a normalized table structure
CREATE TABLE NormalizedProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert data in 1NF format
-- For order 101
INSERT INTO NormalizedProductDetail VALUES (101, 'John Doe', 'Laptop');
INSERT INTO NormalizedProductDetail VALUES (101, 'John Doe', 'Mouse');

-- For order 102
INSERT INTO NormalizedProductDetail VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO NormalizedProductDetail VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO NormalizedProductDetail VALUES (102, 'Jane Smith', 'Mouse');

-- For order 103
INSERT INTO NormalizedProductDetail VALUES (103, 'Emily Clark', 'Phone');

-- Resulting table will have one product per row
SELECT * FROM NormalizedProductDetail;


-- question 2

-- Original table violates 2NF because CustomerName depends only on OrderID (partial dependency)
-- Solution: Split into two tables - Orders and OrderItems

-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderItems table (composite key of OrderID + Product)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into Orders table
INSERT INTO Orders VALUES (101, 'John Doe');
INSERT INTO Orders VALUES (102, 'Jane Smith');
INSERT INTO Orders VALUES (103, 'Emily Clark');

-- Step 4: Insert data into OrderItems table
INSERT INTO OrderItems VALUES (101, 'Laptop', 2);
INSERT INTO OrderItems VALUES (101, 'Mouse', 1);
INSERT INTO OrderItems VALUES (102, 'Tablet', 3);
INSERT INTO OrderItems VALUES (102, 'Keyboard', 1);
INSERT INTO OrderItems VALUES (102, 'Mouse', 2);
INSERT INTO OrderItems VALUES (103, 'Phone', 1);

-- Now the schema is in 2NF:
-- Orders table: CustomerName fully depends on OrderID (primary key)
-- OrderItems table: Quantity fully depends on the composite key (OrderID + Product)
