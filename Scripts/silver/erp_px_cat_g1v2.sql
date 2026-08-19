-- Check unwanted spaces
SELECT *FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
SELECT *FROM bronze.erp_px_cat_g1v2
WHERE subcat != TRIM(subcat)
SELECT *FROM bronze.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance)
SELECT 
-- Data standardization and consistency
SELECT DISTINCT
cat FROM bronze.erp_px_cat_g1v2
WHERE cat !='CAT';
SELECT DISTINCT
    subcat 
FROM bronze.erp_px_cat_g1v2
WHERE subcat != 'SUBCAT';

SELECT DISTINCT
    maintenance 
FROM bronze.erp_px_cat_g1v2
WHERE maintenance IN ('Yes', 'No');

INSERT INTO silver.erp_px_cat_g1v2
(id,cat,subcat,maintenance)
SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2
WHERE cat != 'CAT'
  AND subcat != 'SUBCAT'
  AND maintenance IN ('Yes', 'No');

SELECT *FROM silver.erp_px_cat_g1v2



