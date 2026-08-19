-- SELECT cst_id, COUNT(*) 
-- FROM (
CREATE VIEW gold.dim_customers AS
    SELECT
	ROW_NUMBER () OVER (ORDER BY cst_id)AS cusomer_key,
        ci.cst_id AS customer_ID,
        ci.cst_key AS customer_number,
        ci.cst_firstname AS first_name,
        ci.cst_lastname AS last_name,
		la.cntry AS country,
         CASE WHEN ci.cst_gndr != 'n/a'THEN ci.cst_gndr -- CRM is the master data for gender
		      ELSE COALESCE(ca.gen, 'n/a')
		END AS gender,
		ci.cst_marital_status AS marital_status,
        ca.bdate AS birthdate,
        ci.cst_create_date AS create_date
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca
        ON ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 la
        ON ci.cst_key = la.cid
-- ) t 
-- GROUP BY cst_id
-- HAVING COUNT(*) > 1;
-- checking the quality of data gold.dim_customers
SELECT * FROM gold.dim_customers
SELECT DISTINCT gender FROM gold.dim_customers
