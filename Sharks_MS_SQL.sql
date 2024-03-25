use The_Big_Sharks;
select * from bigsharks;

select *,sum(holding_value_in_cr) as Total_holding_amount from bigsharks group by investor order by total_holding_amount ;

SELECT Top 1 type, investor, SUM(holding_value_in_cr) AS total_holding_amount
FROM bigsharks
WHERE type = 'individual investor'
GROUP BY type, investor
ORDER BY total_holding_amount DESC;
/*type	investor							total_holding_amount
Individual Investor	Premji_and_Associates	194980.90625*/

SELECT Top 1 type, investor, SUM(holding_value_in_cr) AS total_holding_amount
FROM bigsharks
WHERE type = 'institutional investors'
GROUP BY type, investor
ORDER BY total_holding_amount DESC
/*type	investor							total_holding_amount
Institutional Investors	President_of_India	3802901.11915588*/

SELECT Top 1 type, investor, SUM(holding_value_in_cr) AS total_holding_amount
FROM bigsharks
WHERE type = 'FII'
GROUP BY type, investor
ORDER BY total_holding_amount DESC;
/*type	investor							total_holding_amount
Institutional Investors	President_of_India	3802901.11915588*/

SELECT stock, (MAX(holding_value_in_cr) - MIN(holding_value_in_cr)) AS quantity_change 
FROM bigsharks 
GROUP BY stock 
ORDER BY quantity_change DESC;


SELECT DISTINCT TYPE from sharks;

SELECT DISTINCT Investor from sharks;

SELECT DISTINCT Stock from sharks;

-- Total Portfolio value including all Sharks
SELECT SUM(Holding_Value_in_Cr) as Total_Valuation_Crs
FROM bigsharks;

-- Total Holding values as per Types
SELECT TYPE, SUM(Holding_Value_in_Cr) as Total_Valuation_Crs
FROM bigsharks
GROUP BY Type;

-- Total Portfolio Value of Investor

SELECT stock, ROUND(SUM(Holding_Value_in_Cr),2) as Total_Valuation_Crs
FROM bigsharks
GROUP BY stock
ORDER BY Total_Valuation_Crs DESC;

-- Total Stocks held by Investors
SELECT Investor, COUNT(*) as Total_Stocks 
FROM bigsharks
GROUP BY Investor
ORDER BY Total_Stocks DESC;

-- Total Quantity Held by Investor
SELECT Investor, SUM(Quantity) as Total_Quantity
FROM bigsharks
GROUP BY Investor
ORDER BY Total_Quantity DESC;

/*
	SELECT Stock, SUM(Holding_Value_in_Cr * 10000000) / SUM(Quantity) as Avg_Value
	FROM Sharks
	GROUP BY Stock
	ORDER BY Avg_Value DESC;
*/

-- Average price of Stocks in portfolio for years held.
SELECT Stock, 
       COALESCE(SUM(Holding_Value_in_Cr * 10000000) / NULLIF(SUM(Quantity), 0), 0) AS Avg_Value
FROM bigsharks
GROUP BY Stock
ORDER BY Avg_Value DESC;

-- All Banks Preffered by Sharks
SELECT Stock, SUM(Quantity) AS Total_Quantity
FROM bigsharks
WHERE Stock LIKE '%Bank%'
GROUP BY Stock
ORDER BY Total_Quantity DESC;


WITH StockCounts AS (
    SELECT Type, Stock, COUNT(*) AS StockCount, 
	ROW_NUMBER() OVER (PARTITION BY Type ORDER BY COUNT(*) DESC) AS RowNum
    FROM bigsharks
    GROUP BY Type, Stock
)
SELECT Type, Stock, StockCount
FROM StockCounts
WHERE RowNum <= 10;

SELECT Stock, COUNT(*) AS Count
FROM bigsharks
GROUP BY Stock
HAVING COUNT(*) > 2
ORDER BY Count DESC;

select distinct * from bigsharks;

CREATE INDEX index_name
ON bigsharks (holding_value_in_cr,quantity);

select type,investor,stock,coalesce(Holding_value_in_cr,'0') as holding_value_cr , quantity,dec_2023,sep_2023,jun_2023,mar_2023,dec_2023,dec_2022,sep_2022,jun_2022,mar_2022,dec_2021 from Bigsharks