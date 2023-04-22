-- This contains Queries on cleaning of Customer Insight Data  

--Query to Review and Clean the data before Analysis
SELECT [CustomerID],
[OrderDate],
[OnlineOrderFlag],
[TerritoryID],
[FirstName],
[LastName],
[BirthDate],
[MaritalStatus],
[Gender],[YearlyIncome],
[TotalChildren],[EnglishOccupation],[CommuteDistance],[TotalDue]
from [Sales].[SalesOrderHeader] as soh
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]

-- Convert DATETIME to Date for Order Date
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
[FirstName],
[LastName],
[BirthDate],
[MaritalStatus],
[Gender],[YearlyIncome],
[TotalChildren],[EnglishOccupation],[CommuteDistance],[TotalDue]
from [Sales].[SalesOrderHeader] as soh
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]

-- Query to Join First Nmae and Last Name Together
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
[BirthDate],
[MaritalStatus],
[Gender],
[YearlyIncome],
[TotalChildren],[EnglishOccupation],[CommuteDistance],[TotalDue]
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]

-- Calculate the Age of all the customers rather than date of birth
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
DATEDIFF(YEAR,[BirthDate],GETDATE()) AS AGE,
[MaritalStatus]
[Gender],
[YearlyIncome],
[TotalChildren],[EnglishOccupation],[CommuteDistance],[TotalDue]
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]

--Change the Marital Status from M and S to Married and Single Respectively
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
DATEDIFF(YEAR,[BirthDate],GETDATE()) AS AGE,
CASE
WHEN [MaritalStatus] = 'S'
THEN 'SINGLE'
ELSE 'MARRIED'
END AS Marital_Status,
[Gender],
[YearlyIncome],
[TotalChildren],[EnglishOccupation],[CommuteDistance],[TotalDue]
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]

--Change the Marital Status from M and F to Male and Female Respectively
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
DATEDIFF(YEAR,[BirthDate],GETDATE()) AS AGE,
CASE
WHEN [MaritalStatus] = 'S'
THEN 'Single'
ELSE 'Married'
END AS Marital_Status,
CASE
WHEN [Gender] = 'M'
THEN 'Male'
WHEN [Gender] = 'F'
THEN 'Female'
Else 'Non Binary'
END AS Gender,
[YearlyIncome],
[TotalChildren],[EnglishOccupation],[CommuteDistance],[TotalDue]
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]


-- Remove Decimal places from both TotalDue and Yearly Income
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
DATEDIFF(YEAR,[BirthDate],GETDATE()) AS Age,
CASE
WHEN [MaritalStatus] = 'S'
THEN 'Single'
ELSE 'Married'
END AS Marital_Status,
CASE
WHEN [Gender] = 'M'
THEN 'Male'
WHEN [Gender] = 'F'
THEN 'Female'
Else 'N/A'
END AS Gender,
CAST(ROUND ([YearlyIncome],0)AS INT) AS Annual_Income,
[TotalChildren],
[EnglishOccupation],
[CommuteDistance],
CAST(ROUND([TotalDue],0) AS INT) AS Transcaction_Cost
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]
WHERE [OnlineOrderFlag] = 1

-- Change online oder flag into Online or offline channel 
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
CASE
WHEN [OnlineOrderFlag] = 1
THEN 'ONLINE'
ELSE 'OFFLINE'
END AS CHANNEL,
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
DATEDIFF(YEAR,[BirthDate],GETDATE()) AS Age,
CASE
WHEN [MaritalStatus] = 'S'
THEN 'Single'
ELSE 'Married'
END AS Marital_Status,
CASE
WHEN [Gender] = 'M'
THEN 'Male'
WHEN [Gender] = 'F'
THEN 'Female'
Else 'N/A'
END AS Gender,
CAST(ROUND ([YearlyIncome],0)AS INT) AS Annual_Income,
[TotalChildren],
[EnglishOccupation],
[CommuteDistance],
CAST(ROUND([TotalDue],0) AS INT) AS Transcaction_Cost
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]
ORDER BY [Transcaction_Cost] DESC



-- Crete a view to save query
CREATE VIEW CUSTOMER_TRANSACTION_DETAIL AS
SELECT [CustomerID],
CAST([OrderDate] AS DATE) AS ORDERDATE,
[OnlineOrderFlag],
[TerritoryID],
CONCAT([FirstName],' ',[LastName]) AS Full_Name,
DATEDIFF(YEAR,[BirthDate],GETDATE()) AS Age,
CASE
WHEN [MaritalStatus] = 'S'
THEN 'Single'
ELSE 'Married'
END AS Marital_Status,
CASE
WHEN [Gender] = 'M'
THEN 'Male'
WHEN [Gender] = 'F'
THEN 'Female'
Else 'Non Binary'
END AS Gender,
CAST(ROUND ([YearlyIncome],0)AS INT) AS Annual_Income,
[TotalChildren],
[EnglishOccupation],
[CommuteDistance],
CAST(ROUND([TotalDue],0) AS INT) AS Transcaction_Cost
from [Sales].[SalesOrderHeader] as SOH
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS DC
ON SOH.[CustomerID] = DC.[CustomerKey]

--CHECK CREATED VIEW
SELECT *
FROM [dbo].[CUSTOMER_TRANSACTION_DETAIL]

-- The view is loaded to Power BI for data visualization
