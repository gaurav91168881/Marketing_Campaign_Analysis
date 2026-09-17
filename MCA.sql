CREATE DATABASE marketing_campaign_analysis;

USE marketing_campaign_analysis;

-- ------> ## Creating the Tables: <-----------------------

create Table Countries(
	CountryID INT primary key,
    CountryName VARCHAR(100),
    City VARCHAR(100)
);

Create Table  Customers(
	CustomerID INT primary key,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Gender Varchar(15),
    Age INT,
    LocationID INT
);

Create Table Products(
	ProductID INT primary key,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE Customer_Journey (
    JourneyID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    VisitDate DATE,
    Stage VARCHAR(50),
    Action VARCHAR(50),
    Duration DECIMAL(10,2)
);

CREATE TABLE Cust_Review (
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    ReviewDate DATE,
    Rating DECIMAL(2,1),
    Review_Text TEXT
);

CREATE TABLE Engagement_Data (
    EngagementID INT PRIMARY KEY,
    ContentID INT,
    ContentType VARCHAR(50),
    Likes INT,
    Eng_Date DATE,
    CampaignID INT,
    ProductID INT,
    Views_Clicks VARCHAR(20)
);

select * from Countries;
select * from Customers;
select * from Products;
select * from Customer_Journey;
select * from Cust_Review; 
select * from Engagement_Data;

-- -------> ## Verify Row Counts <----------------------
SELECT COUNT(*) AS Total_Countries
FROM Countries;

SELECT COUNT(*) AS Total_Customers
FROM Customers;

SELECT COUNT(*) AS Total_Products
FROM Products;

SELECT COUNT(*) AS Total_Journeys
FROM Customer_Journey;

SELECT COUNT(*) AS Total_Reviews
FROM Cust_Review;

SELECT COUNT(*) AS Total_Engagement
FROM Engagement_Data;

DESC Countries;
DESC Customers;
DESC Products;
DESC Customer_Journey;
DESC Cust_Review;
DESC Engagement_Data;

-- ------> ## Duplicate Records <-----------
## Every Table has a Primary Key so there is no duplicate records.

SELECT CustomerID,
COUNT(*) AS Duplicate_Count
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*)>1;


-- -------> ## QUESTION <--------------------------
-- Customer segmentation : segment customers into  
-- 							Young (<30)  
--                          Adult (30–50) 
--                          Senior (>50)  

Select CustomerID, CustomerName, Age, 
Case 
	When Age < 30 Then 'Young'
    When Age Between 30 and 50 Then 'Adult'
    Else 'Senior'
End as Customer_Segment
from customers;


-- -------> ## QUESTION <--------------------------
-- Find average rating for each customer segment.

Select 
Case 
	When Age < 30 Then 'Young'
	When Age Between 30 and 50 Then 'Adult'
	Else 'Senior'
End as Customer_Segment,
avg(r.rating) as Avg_Rating
from Customers c
inner join Cust_review r
on c.CustomerID = r.CustomerID
Group by Customer_Segment
Order by Avg_Rating desc;

-- The ADULT Customer Segment has the highest average rating and it shows that Marketing Campaign can continue targeting this segment
-- while exploring ways to improve to make happy other segments.


-- -------> ## QUESTION <--------------------------
-- Top 5 countries based on average customer rating.

Select co.CountryName, Round(Avg(cr.rating),2) as Avg_Rating
from cust_review cr
Inner Join customers c
On cr.CustomerID = c.CustomerID

Inner Join countries co
On c.LocationID = co.CountryID

group by co.CountryName
order by Avg_Rating DESC
Limit 5;

-- In these top 5 Countries Customers are Happy. So from this we say that we can use the same strategies in the other countries
-- where Customers are not that happy.


-- -------> ## QUESTION <--------------------------
-- Find inactive customers (no reviews).

Select c.CustomerID, c.CustomerName, c.Email
from customers c
LEFT JOIN cust_review cr
ON c.CustomerID = cr.CustomerID
where cr.CustomerID IS NULL;

-- All the customers submitted atleat 1 review so there are no inactive customers.


-- -------> ## QUESTION <--------------------------
-- Compare engagement with review ratings.
-- In this we want to know Do products with higher engagement also receive higher customer ratings

Select e.ProductID, round(avg(e.Likes),2) as Avg_Likes, round(avg(cr.Rating),2) as Avg_Rating
from engagement_data e
INNER JOIN cust_review cr
ON e.ProductID = cr.ProductID
group by e.ProductID 
order by Avg_Likes Desc;

-- Here Products with high engagement tend to maintain higher customer ratings.


-- -------> ## QUESTION <--------------------------
-- Do customers who completed checkout give higher ratings?

SELECT
    CASE
        WHEN cj.Stage = 'Checkout' THEN 'Checkout Completed'
        ELSE 'Other Stages'
    END AS Journey_Status,
    ROUND(AVG(cr.Rating),2) AS Average_Rating
FROM Customer_Journey cj
INNER JOIN Cust_Review cr
ON cj.CustomerID = cr.CustomerID
GROUP BY Journey_Status;


WITH Customer_Status AS
(
    SELECT CustomerID,
        MAX(CASE
				WHEN LOWER(Stage) = 'checkout' THEN 1
                ELSE 0
            END) AS Checkout_Flag
    FROM Customer_Journey
    GROUP BY CustomerID
)
SELECT
    CASE
        WHEN Checkout_Flag = 1 THEN 'Checkout Completed'
        ELSE 'Other Stages'
    END AS Journey_Status,
    ROUND(AVG(cr.Rating),2) AS Average_Rating
FROM Customer_Status cs
INNER JOIN Cust_Review cr
ON cs.CustomerID = cr.CustomerID
GROUP BY Journey_Status;

-- Customers who completed the checkout journey had an average rating of 3.69, while customers who did not complete checkout had an average rating of 3.68. 
-- This indicates that customers are happy in both the groups are nearly same.


-- -------> ## QUESTION <--------------------------
-- Average journey duration by customer.

Select CustomerID, Round(Avg(duration), 2) as Avg_Journey_Duration
From customer_journey
Group by CustomerID
Order by Avg_Journey_Duration Desc;

