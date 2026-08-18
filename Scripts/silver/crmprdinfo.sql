-- Loading silver.crm_prd_info

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No results
SELECT
    prd_id,
    COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted Spaces
-- Expectation: No Results
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULL or Negative Numbers
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;


-- SELECT * FROM bronze.crm_prd_info
-- EXECUTION

DROP TABLE IF EXISTS silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info (
    prd_id          INT,
    cat_id          VARCHAR(50),
    prd_key         VARCHAR(50),
    prd_nm          VARCHAR(50),
    prd_cost        INT,
    prd_line        VARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    dwh_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO silver.crm_prd_info(
    prd_id ,        
    cat_id ,        
    prd_key,       
    prd_nm,     
    prd_cost,      
    prd_line,     
    prd_start_dt,    
    prd_end_dt  
)

SELECT
prd_id,
REPLACE(SUBSTRING(prd_key,1, 5),'-', '_')AS cat_id,-- Seperate the prd_key in 4 characters
SUBSTRING(prd_key, 7, LENGTH(prd_key))AS prd_key,
prd_nm,
COALESCE(prd_cost,0)AS prd_cost, -- replace NULL with 0
CASE UPPER(TRIM(prd_line))
      WHEN 'M' THEN 'Mountain'
     WHEN 'R' THEN 'Road'
	 WHEN 'S' THEN 'Other Sales'
	 WHEN 'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(
    CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) AS DATE) - INTERVAL '1 day'
    AS DATE
) AS prd_end_dt
FROM bronze.crm_prd_info

-- END
SELECT * FROM silver.crm_prd_info
WHERE SUBSTRING(prd_key, 7, LENGTH(prd_key)) NOT IN-- Checking prd_key not in both
(SELECT sls_prd_key FROM bronze.crm_sales_details)

WHERE SUBSTRING(prd_key, 7, LENGTH(prd_key)) IN  -- Checking prd_key in both
(SELECT sls_prd_key FROM bronze.crm_sales_details)

WHERE (SUBSTRING(prd_key,1, 5),'-', '_')NOT IN -- Filtering out unmatched data after applyong tranformation 
(SELECT distinct id from bronze.erp_px_cat_g1v2) -- checking if this table has similar digits with prd_info
