SET LANGUAGE English;  -- Garante que os meses estejam em inglês

WITH cte AS (
    SELECT
        a.Product,
        a.Category,
        a.Brand,
        a.Description,
        a.Cost_Price,
        a.Sale_Price,
        a.Image_url,
        b.Date,
        b.Customer_Type,
        b.Discount_Band,
        b.Units_Sold,
        (a.Sale_Price * b.Units_Sold) AS Revenue,
        (a.Cost_Price * b.Units_Sold) AS Total_Cost,
        DATENAME(MONTH, b.Date) AS month_name,  -- Retorna o nome do mês corretamente
        FORMAT(b.Date, 'yyyy') AS year
    FROM product_data a
    JOIN product_sales b 
    ON a.Product_ID = b.Product
)

SELECT *,
(1 - discount * 1.0 / 100) * revenue AS discount_revenue
FROM cte a
JOIN discount_data b
ON a.Discount_Band = b.Discount_Band 
AND a.month_name = b.Month; 







