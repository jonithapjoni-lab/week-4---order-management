CREATE DATABASE OMS;
USE OMS;

CREATE TABLE Customer(
 CID INT PRIMARY KEY,
 Name VARCHAR(50) NOT NULL,
 Email VARCHAR(50) UNIQUE
);

CREATE TABLE Product(
 PID INT PRIMARY KEY,
 PName VARCHAR(50) NOT NULL,
 Price DECIMAL(10,2) CHECK(Price>0)
);

CREATE TABLE Orders(
 OID INT PRIMARY KEY,
 CID INT,
 ODate DATE,
 Total DECIMAL(10,2) DEFAULT 0,
 Status VARCHAR(20) DEFAULT 'Pending'
 CHECK(Status IN('Pending','Shipped','Delivered','Cancelled')),
 FOREIGN KEY(CID) REFERENCES Customer(CID)
);

CREATE TABLE Order_Details(
 DID INT PRIMARY KEY,
 OID INT,
 PID INT,
 Qty INT CHECK(Qty>0),
 Price DECIMAL(10,2),
 FOREIGN KEY(OID) REFERENCES Orders(OID) ON DELETE CASCADE,
 FOREIGN KEY(PID) REFERENCES Product(PID)
);

INSERT INTO Customer VALUES
(1,'Jeffrin','jeffrin@gmail.com'),
(2,'Priya','priya@gmail.com');

INSERT INTO Product VALUES
(101,'Laptop',50000),(102,'Mouse',500);

INSERT INTO Orders VALUES
(1,1,'2026-10-26',51000,'Pending');

INSERT INTO Order_Details VALUES
(1,1,101,1,50000),(2,1,102,2,500);

SELECT c.Name,p.PName,d.Qty,d.Price,o.Status
FROM Customer c JOIN Orders o ON c.CID=o.CID
JOIN Order_Details d ON o.OID=d.OID
JOIN Product p ON d.PID=p.PID;

UPDATE Orders SET Status='Shipped' WHERE OID=1;

UPDATE Order_Details SET Qty=3 WHERE DID=2;

DELETE FROM Orders WHERE Status='Cancelled';

SELECT c.Name,o.OID,o.Total,o.Status
FROM Customer c JOIN Orders o ON c.CID=o.CID;

SELECT p.PName,SUM(d.Qty) AS Sold
FROM Product p JOIN Order_Details d ON p.PID=d.PID
GROUP BY p.PID,p.PName;

SELECT c.Name,SUM(o.Total) AS Spending
FROM Customer c JOIN Orders o ON c.CID=o.CID
GROUP BY c.CID,c.Name;

SELECT AVG(Total) FROM Orders;

SELECT SUM(Total) FROM Orders;