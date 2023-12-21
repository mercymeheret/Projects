-- Create Brand table
CREATE TABLE inventory.brand (
    BrandID INT PRIMARY KEY,
    BrandName VARCHAR(255) NOT NULL
);

-- Create Category table
CREATE TABLE inventory.category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

-- Create Item table
CREATE TABLE inventory.item (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(255) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES inventory.category(CategoryID)
);

-- Create Order table
-- Create Order table
CREATE TABLE inventory.[order] (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL
);

-- Create Order_Item table (Many-to-Many relationship between Order and Item)
-- Create Order_Item table
-- Create Order_Item table
CREATE TABLE inventory.order_item (
    OrderID INT,
    ItemID INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES inventory.[order](OrderID),
    FOREIGN KEY (ItemID) REFERENCES inventory.item(ItemID)
);



-- Create Product table
CREATE TABLE inventory.product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    BrandID INT,
    CategoryID INT,
    FOREIGN KEY (BrandID) REFERENCES inventory.brand(BrandID),
    FOREIGN KEY (CategoryID) REFERENCES inventory.category(CategoryID)
);

-- Create Product_Category table (Many-to-Many relationship between Product and Category)
CREATE TABLE inventory.product_category (
    ProductID INT,
    CategoryID INT,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES inventory.product(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES inventory.category(CategoryID)
);

-- Create Product_Meta table
CREATE TABLE inventory.product_meta (
    ProductID INT,
    MetaKey VARCHAR(255) NOT NULL,
    MetaValue VARCHAR(255),
    PRIMARY KEY (ProductID, MetaKey),
    FOREIGN KEY (ProductID) REFERENCES inventory.product(ProductID)
);

-- Create Transaction table
-- Create Transaction table
CREATE TABLE inventory.[transaction] (
    TransactionID INT PRIMARY KEY,
    ProductID INT,
    OrderID INT,
    Quantity INT NOT NULL,
    TransactionDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES inventory.product(ProductID),
    FOREIGN KEY (OrderID) REFERENCES inventory.[order](OrderID)
);

-- Create User table
CREATE TABLE inventory.[user] (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    UserType VARCHAR(50) NOT NULL
);


-- Insert values into the User table
INSERT INTO inventory.[user] (UserID, UserName, FirstName, LastName, Email, Password, UserType)
VALUES 
  (1, 'john_doe', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', 'RegularUser'),
  (2, 'jane_smith', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', 'Admin'),
  (3, 'bob_jones', 'Bob', 'Jones', 'bob.jones@example.com', 'hashed_password_3', 'RegularUser'),
  
  (4, 'alice_wonder', 'Alice', 'Wonder', 'alice.wonder@example.com', 'hashed_password_4', 'RegularUser'),
  (5, 'charlie_brown', 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashed_password_5', 'Admin'),
  (6, 'eve_smith', 'Eve', 'Smith', 'eve.smith@example.com', 'hashed_password_6', 'RegularUser'),
-- Insert more values into the User table

  (7, 'sam_jenkins', 'Sam', 'Jenkins', 'sam.jenkins@example.com', 'hashed_password_7', 'RegularUser'),
  (8, 'emily_white', 'Emily', 'White', 'emily.white@example.com', 'hashed_password_8', 'Admin'),
  (9, 'michael_jackson', 'Michael', 'Jackson', 'michael.jackson@example.com', 'hashed_password_9', 'RegularUser'),
  (10, 'susan_davis', 'Susan', 'Davis', 'susan.davis@example.com', 'hashed_password_10', 'RegularUser');

  -- Insert a value into the Brand table
INSERT INTO inventory.brand (BrandID, BrandName)
VALUES (1, 'Example Brand'),
 (2, 'Second Brand'),
  (3, 'Another Brand'),
  (4, 'New Brand'),
  (5, 'Brand XYZ'),
  (6, 'Popular Brand'),
  (7, 'Top Brand'),
  (8, 'Best Brand'),
  (9, 'Preferred Brand'),
  (10, 'Favorite Brand');

  -- Insert 10 values into the Category table
INSERT INTO inventory.category (CategoryID, CategoryName)
VALUES 
  (1, 'Electronics'),
  (2, 'Clothing'),
  (3, 'Home and Garden'),
  (4, 'Books'),
  (5, 'Toys'),
  (6, 'Sports and Outdoors'),
  (7, 'Beauty and Personal Care'),
  (8, 'Automotive'),
  (9, 'Furniture'),
  (10, 'Health and Wellness');

  -- Insert 10 values into the Item table
INSERT INTO inventory.item (ItemID, ItemName, CategoryID)
VALUES 
  (1, 'Smartphone', 1),
  (2, 'Laptop', 1),
  (3, 'T-Shirt', 2),
  (4, 'Jeans', 2),
  (5, 'Gardening Tools', 3),
  (6, 'Cookbook', 4),
  (7, 'Action Figure', 5),
  (8, 'Running Shoes', 6),
  (9, 'Shampoo', 7),
  (10, 'Car Battery', 8);

  -- Insert 10 values into the Order table
INSERT INTO inventory.[order] (OrderID, OrderDate)
VALUES 
  (1, '2023-01-01'),
  (2, '2023-02-15'),
  (3, '2023-03-10'),
  (4, '2023-04-05'),
  (5, '2023-05-20'),
  (6, '2023-06-15'),
  (7, '2023-07-03'),
  (8, '2023-08-18'),
  (9, '2023-09-12'),
  (10, '2023-10-30');
  -- Insert 10 values into the Order_Item table
INSERT INTO inventory.order_item (OrderID, ItemID, Quantity)
VALUES 
  (1, 1, 5),
  (1, 2, 2),
  (2, 3, 1),
  (2, 4, 3),
  (3, 5, 2),
  (3, 6, 1),
  (4, 7, 4),
  (4, 8, 2),
  (5, 9, 3),
  (5, 10, 1);

  -- Insert 10 values into the Product table
INSERT INTO inventory.product (ProductID, ProductName, BrandID, CategoryID)
VALUES 
  (1, 'Laptop A', 1, 1),
  (2, 'Smartphone X', 2, 1),
  (3, 'T-Shirt Red', 3, 2),
  (4, 'Jeans Classic', 4, 2),
  (5, 'Garden Tools Set', 5, 3),
  (6, 'Cookbook Best Recipes', 1, 4),
  (7, 'Action Figure Hero', 6, 5),
  (8, 'Running Shoes Pro', 7, 6),
  (9, 'Shampoo Fresh Scent', 8, 7),
  (10, 'Car Battery XL', 9, 8);

  -- Insert 10 values into the Product_Category table
INSERT INTO inventory.product_category (ProductID, CategoryID)
VALUES 
  (1, 1),
  (2, 1),
  (3, 2),
  (4, 2),
  (5, 3),
  (6, 4),
  (7, 5),
  (8, 6),
  (9, 7),
  (10, 8);

-- Insert 10 values into the Product_Meta table
INSERT INTO inventory.product_meta (ProductID, MetaKey, MetaValue)
VALUES 
  (1, 'Weight', '2.5 kg'),
  (2, 'Screen Size', '6 inches'),
  (3, 'Material', 'Cotton'),
  (4, 'Fit', 'Slim Fit'),
  (5, 'Number of Tools', '10'),
  (6, 'Pages', '300'),
  (7, 'Hero Name', 'Superman'),
  (8, 'Shoe Size', '10'),
  (9, 'Scent Type', 'Fresh'),
  (10, 'Voltage', '12V');

  INSERT INTO inventory.[transaction] (TransactionID, ProductID, OrderID, Quantity, TransactionDate)
VALUES 
  (1, 1, 1, 2, '2023-01-02'),
  (2, 2, 2, 1, '2023-02-16'),
  (3, 3, 3, 3, '2023-03-11'),
  (4, 4, 4, 2, '2023-04-06'),
  (5, 5, 5, 1, '2023-05-21'),
  (6, 6, 6, 4, '2023-06-16'),
  (7, 7, 7, 2, '2023-07-04'),
  (8, 8, 8, 3, '2023-08-19'),
  (9, 9, 9, 1, '2023-09-13'),
  (10, 10, 10, 2, '2023-10-31');

  -- Select all products
SELECT * FROM inventory.[user]
