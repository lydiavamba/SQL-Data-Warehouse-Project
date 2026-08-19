-- Foreign Key Integrity (Dimensions)
SELECT *
FROM gold.fact_sale f
LEFT JOIN gold.dim_customers c
    ON c.cusomer_key = f.cusomer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL;
