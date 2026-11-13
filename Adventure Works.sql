use adventure_works;
SHOW TABLES;
DESCRIBE factinternetsales;
DESCRIBE fact_internet_sales_new;

CREATE TABLE Sales_Union AS
SELECT * FROM factinternetsales
UNION ALL
SELECT * FROM fact_internet_sales_new;

DESCRIBE Sales_Union;
DESCRIBE dimproduct;
DESCRIBE dimcustomer;

SHOW COLUMNS FROM Sales_Union;

-- Q1
SELECT
    s.*,
    p.EnglishProductName AS ProductName
FROM sales_union s
LEFT JOIN dimproduct p
    ON s.ProductKey = p.ProductKey;

SELECT
    ProductKey, ProductName
FROM (
    SELECT
        s.ProductKey,
        p.EnglishProductName AS ProductName
    FROM sales_union s
    LEFT JOIN dimproduct p
        ON s.ProductKey = p.ProductKey
) AS ProductLookup;

-- Q2
SELECT
    CustomerKey, CustomerFullName, ProductKey, LookupUnitPrice
FROM (
    SELECT s.CustomerKey,
        CONCAT_WS(' ', NULLIF(c.FirstName, ''), NULLIF(c.MiddleName, ''), NULLIF(c.LastName, '')) AS CustomerFullName,
        s.ProductKey, p.`Unit price` AS LookupUnitPrice
    FROM sales_union s
    LEFT JOIN dimcustomer c
        ON s.CustomerKey = c.CustomerKey
    LEFT JOIN dimproduct p
        ON s.ProductKey = p.ProductKey
) AS CustomerProductLookup;


-- Q3
SELECT
    OrderDateKey,
    STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d') AS OrderDate,
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year,
    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Monthno,
    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Monthfullname,
    CONCAT('Q', QUARTER(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))) AS Quarter,
    DATE_FORMAT(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'), '%Y-%b') AS YearMonth,
    WEEKDAY(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 1 AS Weekdayno,
    DAYNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Weekdayname,
    MOD(MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 5, 12) + 1 AS FinancialMonth,
    CONCAT(
        'Q',
        QUARTER(DATE_ADD(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'), INTERVAL 6 MONTH))
    ) AS FinancialQuarter
FROM sales_union;

-- Q4
SELECT
    ProductKey, UnitPrice, OrderQuantity, UnitPriceDiscountPct,
    ROUND(UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct / 100),2) AS CalculatedSalesAmount
FROM sales_union;

-- Q5
SELECT
    ProductKey, ProductStandardCost AS UnitCost, OrderQuantity,
    ROUND(ProductStandardCost * OrderQuantity, 2) AS CalculatedProductionCost
FROM sales_union;

-- Q6
SELECT
    ProductKey, UnitPrice, OrderQuantity,
    ROUND(UnitPrice * OrderQuantity, 2) AS SalesAmount,
    ProductStandardCost AS UnitCost,
    ROUND(ProductStandardCost * OrderQuantity, 2) AS ProductionCost,
    ROUND((UnitPrice * OrderQuantity) - (ProductStandardCost * OrderQuantity),2) AS Profit
FROM sales_union;