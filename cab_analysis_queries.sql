-- CREATE database ola_project;
use ola_project; 

-- Q1. Total Number of Bookings
SELECT COUNT(*) AS Total_Bookings
FROM cab_booking_analytics_70000;

-- Q2. Total Successful Rides
SELECT COUNT(*) AS Successful_Rides
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success';

-- Q3. Total Revenue Generated
SELECT SUM(Total_Fare) AS Total_Revenue
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success';

-- Q4. Revenue by Vehicle Type
SELECT
    Vehicle_Type,
    COUNT(*) AS Total_Rides,
    SUM(Total_Fare) AS Total_Revenue
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY Total_Revenue DESC;

-- Q5. Top 10 Customers by Amount Spent
SELECT
    Customer_ID,
    COUNT(*) AS Total_Bookings,
    SUM(Total_Fare) AS Total_Amount_Spent
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Customer_ID
ORDER BY Total_Amount_Spent DESC
LIMIT 10;

-- Q6. Cancellation Analysis
SELECT
    Cancellation_Reason,
    COUNT(*) AS Total_Cancellations
FROM cab_booking_analytics_70000
WHERE Booking_Status <> 'Success'
GROUP BY Cancellation_Reason
ORDER BY Total_Cancellations DESC;

-- Q7. Average Ride Distance by Vehicle Type
SELECT
    Vehicle_Type,
    ROUND(AVG(Ride_Distance_km),2) AS Average_Distance
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY Average_Distance DESC;

-- Q8. Peak Booking Hours
SELECT
    HOUR(Booking_Time) AS Booking_Hour,
    COUNT(*) AS Total_Bookings
FROM cab_booking_analytics_70000
GROUP BY Booking_Hour
ORDER BY Total_Bookings DESC;

-- Q9. Rank Drivers Based on Revenue
SELECT
    Driver_ID,
    SUM(Total_Fare) AS Total_Revenue,
    RANK() OVER(ORDER BY SUM(Total_Fare) DESC) AS Driver_Rank
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Driver_ID;

-- Q10. Monthly Revenue Trend
SELECT
    MONTH(Booking_Date) AS Month_Number,
    MONTHNAME(Booking_Date) AS Month_Name,
    COUNT(*) AS Total_Rides,
    SUM(Total_Fare) AS Total_Revenue
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY MONTH(Booking_Date), MONTHNAME(Booking_Date)
ORDER BY Month_Number;

-- Q11. Top 5 Cities by Revenue
SELECT
    Pickup_City,
    SUM(Total_Fare) AS Total_Revenue
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Pickup_City
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Q12. Most Preferred Payment Method
SELECT
    Payment_Method,
    COUNT(*) AS Total_Transactions
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Payment_Method
ORDER BY Total_Transactions DESC;

-- Q13. Highest Average Fare by Vehicle Type
SELECT
    Vehicle_Type,
    ROUND(AVG(Total_Fare),2) AS Average_Fare
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY Average_Fare DESC;

-- Q14. Weather-wise Revenue
SELECT
    Weather,
    COUNT(*) AS Total_Rides,
    SUM(Total_Fare) AS Total_Revenue
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Weather
ORDER BY Total_Revenue DESC;

-- Q15. Customer Segmentation Using CASE
SELECT
    Customer_ID,
    SUM(Total_Fare) AS Total_Spent,
    CASE
        WHEN SUM(Total_Fare) <= 1000 THEN 'Low Value'
        WHEN SUM(Total_Fare) <= 3000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS Customer_Category
FROM cab_booking_analytics_70000
WHERE Booking_Status = 'Success'
GROUP BY Customer_ID
ORDER BY Total_Spent DESC;