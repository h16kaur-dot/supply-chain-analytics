USE supply_chain;
DROP TABLE IF EXISTS supply_chain_cleaned;
CREATE TABLE supply_chain_cleaned (
    Type VARCHAR(50),
    Days_for_shipping_real INT,
    Days_for_shipment_scheduled INT,
    Benefit_per_order FLOAT,
    Sales_per_customer FLOAT,
    Delivery_Status VARCHAR(50),
    Late_delivery_risk INT,
    Category_Id INT,
    Category_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Customer_Country VARCHAR(100),
    Customer_Email VARCHAR(100),
    Customer_Fname VARCHAR(50),
    Customer_Id INT,
    Customer_Lname VARCHAR(50),
    Customer_Segment VARCHAR(50),
    Customer_State VARCHAR(100),
    Customer_Street VARCHAR(200),
    Customer_Zipcode VARCHAR(20),
    Department_Id INT,
    Department_Name VARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT,
    Market VARCHAR(50),
    Order_City VARCHAR(100),
    Order_Country VARCHAR(100),
    Order_Customer_Id INT,
    Order_Date VARCHAR(50),
    Order_Id INT,
    Order_Item_Cardprod_Id INT,
    Order_Item_Discount FLOAT,
    Order_Item_Discount_Rate FLOAT,
    Order_Item_Id INT,
    Order_Item_Product_Price FLOAT,
    Order_Item_Profit_Ratio FLOAT,
    Order_Item_Quantity INT,
    Sales FLOAT,
    Order_Item_Total FLOAT,
    Order_Profit_Per_Order FLOAT,
    Order_Region VARCHAR(100),
    Order_State VARCHAR(100),
    Order_Status VARCHAR(50),
    Order_Zipcode VARCHAR(20),
    Product_Card_Id INT,
    Product_Category_Id INT,
    Product_Name VARCHAR(200),
    Product_Price FLOAT,
    Product_Status INT,
    Ship_Date VARCHAR(50),
    Shipping_Mode VARCHAR(50),
    delivery_delay_days INT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/supply_chain_cleaned.csv'
INTO TABLE supply_chain_cleaned
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM supply_chain_cleaned;

SELECT 
    Category_Name,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS Avg_Profit_Per_Order
FROM supply_chain_cleaned
GROUP BY Category_Name
ORDER BY Total_Sales DESC;

SELECT 
    Order_Region,
    COUNT(*) AS Total_Orders,
    SUM(Late_delivery_risk) AS Late_Deliveries,
    ROUND((SUM(Late_delivery_risk) / COUNT(*)) * 100, 2) AS Late_Delivery_Rate_Percent
FROM supply_chain_cleaned
GROUP BY Order_Region
ORDER BY Late_Delivery_Rate_Percent DESC;

SELECT 
    Product_Name,
    COUNT(*) AS Times_Ordered,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    ROUND(AVG(Order_Item_Profit_Ratio) * 100, 2) AS Avg_Profit_Margin_Percent
FROM supply_chain_cleaned
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

SELECT 
    Customer_Segment,
    COUNT(DISTINCT Customer_Id) AS Total_Customers,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM supply_chain_cleaned
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC;

SELECT 
    Delivery_Status,
    COUNT(*) AS Total_Orders,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM supply_chain_cleaned)) * 100, 2) AS Percentage,
    ROUND(AVG(delivery_delay_days), 1) AS Avg_Delay_Days
FROM supply_chain_cleaned
GROUP BY Delivery_Status
ORDER BY Total_Orders DESC;

SELECT 
    SUBSTRING(Order_Date, 1, 7) AS Order_Month,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Monthly_Sales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Monthly_Profit
FROM supply_chain_cleaned
GROUP BY Order_Month
ORDER BY Order_Month ASC;

SELECT 
    Shipping_Mode,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Days_for_shipping_real), 1) AS Avg_Actual_Days,
    ROUND(AVG(Days_for_shipment_scheduled), 1) AS Avg_Scheduled_Days,
    ROUND(AVG(delivery_delay_days), 1) AS Avg_Delay_Days,
    SUM(Late_delivery_risk) AS Late_Deliveries
FROM supply_chain_cleaned
GROUP BY Shipping_Mode
ORDER BY Avg_Delay_Days DESC;


SELECT 
    Order_City,
    Order_Country,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM supply_chain_cleaned
GROUP BY Order_City, Order_Country
ORDER BY Total_Orders DESC
LIMIT 10;


SELECT 
    Order_Id,
    Customer_Segment,
    Order_Region,
    Shipping_Mode,
    Days_for_shipping_real,
    Days_for_shipment_scheduled,
    delivery_delay_days,
    Sales
FROM supply_chain_cleaned
WHERE Late_delivery_risk = 1
AND delivery_delay_days > 5
ORDER BY delivery_delay_days DESC
LIMIT 20;


SELECT 
    Department_Name,
    COUNT(*) AS Total_Orders,
    COUNT(DISTINCT Product_Name) AS Unique_Products,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    ROUND((SUM(Late_delivery_risk) / COUNT(*)) * 100, 2) AS Late_Rate_Percent
FROM supply_chain_cleaned
GROUP BY Department_Name
ORDER BY Total_Sales DESC;