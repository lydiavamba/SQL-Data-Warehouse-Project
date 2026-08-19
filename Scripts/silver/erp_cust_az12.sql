-- -- Check For Nulls or Duplicates in Primary Key
 SELECT DISTINCT
    bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > CURRENT_DATE;
-- SELECT cid,COUNT(*)FROM bronze.erp_cust_az12
-- GROUP BY cid
-- HAVING COUNT(*)>1 OR cid IS NULL;
-- -- Data Standardization & Consistency
SELECT DISTINCT gen
FROM bronze.erp_cust_az12;
INSERT INTO silver.erp_cust_az12(cid,bdate,gen)
SELECT 
    CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LENGTH(cid))
         ELSE cid
    END AS cid,
    CASE WHEN bdate > CURRENT_DATE THEN NULL
         ELSE bdate
    END AS bdate,
    CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
		 ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12;
SELECT *FROM silver.erp_cust_az12

-- -- TO check if data are matching for two tables
WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4, LENGTH(cid) )
     ELSE cid
END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)
