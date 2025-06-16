USE CourierManagementSystem;
Create database  If not Exists CourierManagementSystem;
show tables;

create table Employee(EmployeeID int PRIMARY KEY, Nmae varchar(255), Email varchar(255)UNIQUE, ContactNumber varchar(20), Role varchar(50), Salary decimal(10, 2) );

create table Location(LocationID INT PRIMARY KEY, LocationName VARCHAR(100), Address TEXT); 
select * from Location;

create table Courier(CourierID INT PRIMARY KEY, SenderName VARCHAR(255), SenderAddress TEXT, ReceiverName VARCHAR(255), ReceiverAddress TEXT,
Weight DECIMAL(5, 2), Status VARCHAR(50), TrackingNumber VARCHAR(20) UNIQUE, DeliveryDate DATE, UserID INT , EmployeeID INT, foreign key (UserID) references User(UserID), foreign key(EmployeeID) references Employee(EmployeeID)); 

desc User;
drop table Courier;
 create table CourierServices( ServiceID int primary key, ServiceName varchar(100), Cost Decimal(8, 2));
 
 create table Payment(PaymentID int primary key, CourierID int, LocationID int, Amount decimal(10, 2), PaymentDate Date, foreign key (CourierID) references Courier(CourierID), foreign key(LocationID) references Location(LocationID));
 
 SELECT * FROM User;
 insert into User values (1, 'Netra D', 'netrad@gmail.com', '234', '45678-98765', 'A-199, MN , Nagpur'),( 2, ' Aniket', 'aniket234@gmail.com', 'pass4564', '88678-90765', 'Sector-23,Delhi'), (3, 'Palash H', 'palash09@gmail.com', 'palash23', '98909-98765', 'pune'), (4, 'Pallavi', 'pallavi@gmail.com', 'pallav8988', '45678-90009', 'Umred');
 
 insert into Employee values (1010, 'Ashish D', 'ashishd@eg.com', '00-678-5678', 'Admin', 50000), (1020, 'Shital D', 'shitalshd@eg.com', '00-6456-5678', 'Manager', 60000), (1030, 'Snehal D', 'snehald@eg.com', '00-678-58899', 'Customer Service', 34000) , (1040, 'Ashish Dev', 'ashishd345@eg.com', '00-677890-78', 'Delivery guy', 30000);
 SELECT * FROM Employee;
 
 insert into Location values(209, 'Cyber city', '456-B, Cyber hub, NGP'), (289, 'Mihan', 'A-399, Mihan Near AIIMS, NGP'), (299, 'IT Park', '456-B,Blinc Innovations, NGP');
 
 insert into Courier values (89, 'Netra D', 'A-199, MN , Nagpur', 'Usha D', 'Wani', 7.68, 'Delivered', 'TRKID0009', '2025-06-2', 1,1010), (90, 'Palash H', 'pune', 'Chaya', 'Chandrapur', 6.68, 'In Transit', 'TRKID4009', '2025-06-28', 3,null), (92, 'Palash H', 'pune', 'Pallavi', 'Umred', 56.8, 'Processing', 'TRKID3409', '2025-07-23', 3,1030);
 
 SELECT * FROM Courier;
 
 insert into CourierServices values(300, 'Express Delivery', 67.89), (302, 'Standard Delivery', 23.89);
 SELECT * FROM CourierServices;
 
 insert into Payment values(401, 89, 209, 60, '2025-06-2'), (402, 90, 299, 78.65, '2025-06-28');
 Select * from Payment;
 
 
 
 -- 01 List all customers
 SELECT * FROM User;
 
 
 
 
 
 
 
 -- 02 
 select * from Courier
 Where UserID= 3;
 
 
 
 -- 03
 select * from Courier;
 
 
 
 
 -- 04 all packages for specific orders
 select * from Courier
 where CourierId = 90; 
 
 
 
 -- 05 
 Select * From Courier 
 Where SenderName = 'Palash H';
 
 
 
 
 -- 06 
 select * from Courier 
 where Status != 'Delivered';
 
 
 -- 07
 select * from Courier where  DeliveryDate = current_date;
 
 
 
 
 -- 08
 select * from Courier
 where Status = 'Processing';
 
 
 
 -- 09
 Select SenderName, Count(*) As TotalNoOfPackages From Courier 
 Group by SenderName;
 
 
 -- 10
 Select SenderName, Avg(datediff(DeliveryDate, OrderDate)) As AverageDeliveryTime
 From Courier 
 Group by SenderName;
 
 Select * from Courier;
 
 
 
 
 -- 11
 select * from Courier
 where Weight between 2.5 and 6.8;
 
 -- 12
 desc Employee;
 INSERT INTO Employee VALUES ('8', 'John Cena', 'wwejohncena@gmail.com', '99-08754688','Customer Service', '30989');
 SELECT * FROM Employee
 WHERE Name LIKE '%John%';
 
 
 
 
 
 alter table Employee change column Nmae Name varchar(255);
 desc Employee;
 
 
 -- 13
SELECT * FROM Courier C
LEFT JOIN Payment P
ON C.CourierID = P.CourierID
WHERE P.Amount > 50.00;
 
 
 -- TASK 3
 -- 14
SELECT E.Name, COUNT(C.CourierID) AS TotalCouriersHandled
FROM Employee E
LEFT JOIN Courier C ON E.EmployeeID = C.EmployeeID
GROUP BY E.Name;
 
 -- 15
SELECT L.LocationName, SUM(P.Amount) AS TotalRevenue
FROM Location L
LEFT JOIN Payment P ON L.LocationID = P.LocationID
GROUP BY L.LocationName;
 
 -- 16
 SELECT L.LocationName, COUNT(C.CourierID) As TotalCourierDelivered From Location L
 Inner join Payment P ON  L.LocationID = P.LocationID 
 Inner join Courier C ON P.CourierID = C.CourierID
 Where  C.Status = 'Delivered'
 Group by L.LocationName;
 
 
 Select * from Courier ;
 

 
 
 
 -- 17
 -- average delivery time = order date & delivered date required
 alter table Courier 
 add column OrderDate Date;
 
update Courier set OrderDate = '2025-05-20' 
where  CourierID = 89;
 
update Courier set OrderDate = '2025-06-02' 
where  CourierID = 90;
 
update Courier set OrderDate = '2025-06-18' 
where  CourierID = 92;
 
SELECT CourierID,  AVG(DATEDIFF(DeliveryDate, OrderDate)) AS AvgDeliveryTime
FROM Courier 
WHERE Status = 'Delivered'
GROUP BY CourierID
ORDER BY AvgDeliveryTime DESC
LIMIT 1;
 
 
 
 
 
 -- 18
SELECT L.LocationName, SUM(P.Amount) AS TotalPayment
FROM Location L
INNER JOIN Payment P ON L.LocationID = P.LocationID
GROUP BY L.LocationName
HAVING SUM(P.Amount) < 70.00;


 
 -- 19
 SELECT L.LocationName, SUM(P.Amount) AS TotalPayments
FROM Location L
LEFT JOIN Payment P ON L.LocationID = P.LocationID
GROUP BY L.LocationName;
 
 
 -- 20

 
SELECT C.CourierID, C.TrackingNumber, SUM(P.Amount) AS TotalPayments
FROM Courier C
INNER JOIN Payment P 
ON C.CourierID = P.CourierID
WHERE P.LocationID = 1
GROUP BY C.CourierID, C.TrackingNumber
HAVING SUM(P.Amount) > 1000;
 
 USE CourierManagementSystem;

INSERT INTO User VALUES
(101, 'Arun S', 'arun@example.com', 'arun@123', '9876543210', 'Chennai'),
(102, 'Riya M', 'riya@example.com', 'riya@123', '9876543211', 'Mumbai');

INSERT INTO Employee VALUES
(201, 'John Mathew', 'john@example.com', '9999999999', 'Delivery Boy', 25000.00),
(202, 'Meena Sharma', 'meena@example.com', '8888888888', 'Manager', 50000.00);
 
 INSERT INTO Location VALUES
(1, 'Mumbai', 'Andheri East'),
(2, 'Chennai', 'T Nagar'),
(3, 'Bangalore', 'BTM Layout');

INSERT INTO Courier VALUES
(1, 'Arun S', 'Chennai', 'Ravi Kumar', 'Mumbai', 2.5, 'Delivered', 'TRK001', '2024-06-10', 101, 201, '2024-06-01', 300),
(2, 'Riya M', 'Mumbai', 'Sneha', 'Chennai', 1.0, 'In Transit', 'TRK002', '2024-06-15', 102, 202, '2024-06-05', 302);

INSERT INTO Payment VALUES
(1, 1, 1, 600.00, '2024-06-02'),
(2, 1, 1, 500.00, '2024-06-03'),

-- Courier 2 gets 1 payment of 450
(3, 2, 2, 450.00, '2024-06-04');


 -- 21
SELECT C.CourierID, C.TrackingNumber, SUM(P.Amount) AS TotalPayments
FROM Courier C
INNER JOIN Payment P 
ON C.CourierID = P.CourierID
WHERE P.PaymentDate > '2025-06-01'
GROUP BY C.CourierID, C.TrackingNumber
HAVING SUM(P.Amount) > 1000;


SELECT CourierID FROM Payment WHERE PaymentDate > '2024-06-01' GROUP BY CourierID HAVING SUM(Amount) > 1000;



INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate) VALUES
(4, 1, 1, 2000.00, '2024-05-15'),
(5, 2, 1, 1800.00, '2024-05-18'),
(6, 2, 1, 1300.00, '2024-05-20');


 
 -- 22
SELECT LocationID , Sum(Amount) AS TotalAmount
FROM Payment 
WHERE PaymentDate < '2024-06-01' 
GROUP BY LocationID 
HAVING SUM(Amount) > 5000;
 
 -- 23
SELECT P.*, C.TrackingNumber, C.Status
FROM Payment P
INNER JOIN Courier C ON P.CourierID = C.CourierID;

sELECT *FROM Courier;
-- 24
SELECT P.* , L.LocationName, L.Address
FROM PAYMENT P 
INNER JOIN Location L 
on L.LocationID = P.LocationID;

-- 25
SELECT P.*, C.SenderName,C.Status, L.LocationName, L.Address
FROM Payment P 
INNER JOIN Courier C on P.CourierID = C.CourierID
INNER JOIN Location L on P.LocationID = L.LocationID;

-- 26
SELECT P.* , C.SenderName, C.Status, C.ReceiverName
FROM Payment P 
INNER JOIN Courier C on P.CourierID = C.CourierID;



-- 27
Select C.CourierID , C.TrackingNumber, SUM(P.Amount) as TotalPayment
from Courier C
left join Payment P 
on C.CourierID = P.CourierID
Group by C.TrackingNumber, C.CourierID;

use CourierManagementSystem;


-- 28
Select * from Payment 
Where PaymentDate = '2025-06-02';



-- 29
Select P.*, C.CourierID, C.Status, C.SenderName
from Payment P
Left join  Courier C
on P.CourierID = C.CourierID;



-- 30
Select P.*, L.LocationName, L.Address
From Payment P 
Inner join Location L on P.LocationID = L.LocationID;

-- 31
insert into Courier values (80, 'Netra D', 'A-199, MN , Nagpur', 'Sanjay', 'Yavatmal', 2.68, 'Delivered', 'TRKID0029', '2025-06-20', 1,1010, '2025-06-02');

-- 31
Select C.SenderName, Sum(P.Amount) As TotalPayment
From Courier C 
Left Join Payment P on C.CourierID = P.CourierID
Group by C.SenderName;


-- 32
Select * from Payment
Where PaymentDate between '2025-06-02' And '2025-06-20';



-- 33
Select U.Name as UserName, U.UserID, C.CourierID, C.TrackingNumber, C.Status
From User U 
left join Courier C on U.UserID = C.UserID

UNION ALL 

Select  U.Name as UserName, U.UserID, C.CourierID, C.TrackingNumber, C.Status
From User U 
right join Courier C on U.UserID = C.UserID
where U.UserID is null;


-- 34
alter table Courier add column ServiceID int;
alter table Courier add FOREIGN KEY (ServiceID) REFERENCES CourierServices(ServiceID);

INSERT INTO Courier (CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate, UserID, EmployeeID, OrderDate, ServiceID) VALUES
(5, 'Pallavi', 'Umred', 'Netra D', 'A-199, MN , Nagpur', 7.50, 'Processing', 'TRK0025', '2025-07-02', 4, 1010, '2025-07-20', 302);

Select C.CourierID, CS.ServiceName
From Courier C 
Left Join CourierServices CS
On C.ServiceID = CS.ServiceID

UNION ALL

Select C.CourierID , CS.ServiceName
From Courier C 
Right join CourierServices CS
on C.ServiceID = CS.ServiceID
Where CourierID is null;


-- 35
Select E.*, C.CourierID, C.TrackingNumber, C.Status
From Employee E
Left join Courier C
On E.EmployeeID = C.EmployeeID

union all 

Select E.*, C.CourierID, C.TrackingNumber, C.Status
From Employee E
Right join Courier C
On E.EmployeeID = C.EmployeeID;

-- 36

Select U.Name as UserName, CS.ServiceName
From User U, CourierServices CS;

-- 37
Select E.Name as EmployeeName, L.LocationName
From Employee E, Location L;


-- 38
SELECT CourierID,SenderName, SenderAddress, TrackingNumber, Status,  OrderDate
FROM   Courier;


-- 39
SELECT CourierID, TrackingNumber, ReceiverName, ReceiverAddress
 FROM Courier;
 
 
 desc Courier;
-- 40 
Select C.CourierID, C.TrackingNumber, C.Status, CS.ServiceName, CS.Cost
From Courier C 
Left Join CourierServices CS 
on C.ServiceID = CS.ServiceID;

-- 41
Select E.Name as EmpNAme, Count(C.CourierID) As NoOfCourierAssgn
From Employee E
Left join Courier C 
on E.EmployeeID = C.EmployeeID
Group by E.Name;

desc Payment;
-- 42

Select L.LocationName, Sum(P.Amount) As TotalAmountReceived
From Location L 
Left Join Payment P 
on L.LocationID = P.LocationID
Group By L.LocationName;


-- 43
Select C.TrackingNumber, C.SenderName
From Courier C 
Where C.SenderName in(
	Select SenderName 
    From Courier 
    Group by SenderName
    Having Count(*) > 1)
order by SenderName;




-- 44
Select Role, Count(*)  as NumOfEmployee
From Employee
Group by Role
Having Count(*) > 1;

desc Employee;
Select * from Employee;
insert into Employee values(1050, 'Pranit', 'pranit3456@gmail.com', '92-8879-678890', 'Delivery guy', '30000'),
(1060, 'Shivang', 'shivang6@gmail.com', '92-8879-666890', 'Delivery guy', '30000'),
(1070, 'Krushant', 'krushant3456@gmail.com', '92-8339-678890', 'Delivery guy', '30000'),
(1080, 'Taylii', 'taylii3456@gmail.com', '92-8879-678890', 'Manager', '60000');



-- 45
Select P.* , C.SenderAddress
From Payment P 
Inner Join Courier C 
on P.CourierID = C.CourierID
where SenderAddress IN(
	Select SenderAddress 
    From Courier 
    Group by SenderAddress
    Having Count(*) > 1);
    
SELECT P.*, C.SenderAddress
FROM Payment P
JOIN Courier C ON P.CourierID = C.CourierID
WHERE C.SenderAddress IN (
    SELECT SenderAddress
    FROM Courier
    GROUP BY SenderAddress
    HAVING COUNT(*) > 1
);

    
    insert into Payment Values(403, 92, 299, 90.35,'2025-06-07');



Select LocationID from Location;


Select * from Payment;
Select * from Location;


-- 46
Select SenderName, SenderAddress, TrackingNumber from Courier
where SenderAddress IN(
	Select SenderAddress 
    From Courier
    Group By SenderAddress
    having Count(*) > 1);


-- 47 

Select * from Courier;
Select * from Employee;

SELECT E.Name AS EmployeeName, Count(C.CourierID) AS CouriersDelivered
FROM Employee E
LEFT JOIN Courier C ON E.EmployeeID = C.EmployeeID AND C.Status = 'Delivered'
GROUP BY E.Name;














-- 48


Select * From CourierServices;
update Courier Set ServiceID = 301 where CourierID = 80;

Select * from Payment;
INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate)
VALUES (1000, 92, 209, 160.00, '2025-06-12');

INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate)
VALUES (999, 92, 209, 150.00, '2025-06-12');

--
SELECT CourierID, ServiceID FROM Courier;
SELECT * FROM CourierServices WHERE ServiceID = 302;
INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate)
VALUES (1001, 5, 209, 50.00, '2025-06-12');
Select * from Location;

SELECT P.PaymentID, P.Amount, C.CourierID, CS.Cost AS ServiceCost
FROM Payment P
JOIN Courier C ON P.CourierID = C.CourierID
JOIN CourierServices CS ON C.ServiceID = CS.ServiceID
WHERE P.Amount > CS.Cost;



















-- 49
Select * from Courier 
Where Weight > (Select Avg(Weight) From Courier);





-- 50 
Select Name , Salary From Employee
Where Salary > (Select Avg(Salary) From Employee);



-- 51
Select  Sum(Cost)
From CourierServices
Where Cost< (Select Max(Cost) From CourierServices);


Select * from CourierServices;


-- 52
Desc Courier;
desc Payment ;
Select * from Payment;

Select C.CourierID, C.Status, C.TrackingNumber, P.PaymentDate, P.Amount
from Courier C 
INNER JOIN Payment P 
on C.CourierID = P.CourierID;



-- 53
Desc Location;
Desc Payment;

SELECT L.LocationName, P.Amount
FROM Payment P
JOIN Location L ON P.LocationID = L.LocationID
WHERE P.Amount = (SELECT MAX(Amount) FROM Payment);


INSERT INTO Courier VALUES (
    93, 'Pallavi', 'Umred', 'Usha D', 'Wani',
    60.00, 'Processing', 'TRKID9999', '2025-06-30', 4,
    1030, '2025-06-12', 302
);


-- 54
desc Courier;
Select Weight , SenderName
from Courier 
where Weight > ALL(Select Weight From Courier Where SenderName = 'Palash H');


Select * from Courier;


Select * From Courier;


-- 45
Select C.SenderAddress, COUNT(P.PaymentID) AS NumberOfPaymentsMade
From Payment P
Join Courier C ON P.CourierID = C.CourierID
Group by C.SenderAddress;




create database car_rental_system;
use car_rental_system;





 

