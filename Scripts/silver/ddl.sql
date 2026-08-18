-- Loading silver.crm_cust_info
INSERT INTO silver.crm_cust_info(
cst_id,cst_key,cst_firstname,cst_lastname,cst_marital_status,cst_gndr,cst_create_date
)
SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_material_status))='M' THEN 'Married'
     WHEN UPPER(TRIM(cst_material_status))='S' THEN 'Single'
	 ELSE 'n/a'
END cst_material_status,-- Normalize marital status values to readable format
CASE WHEN UPPER(TRIM(cst_gndr)) ='F' THEN 'Female'
     WHEN UPPER(TRIM(cst_gndr)) ='M' THEN 'Male'
	 ELSE 'n/a'
END cst_gndr, --Normalize gender values to readable format
cst_create_date
FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
) t
WHERE flag_last =1  --Select the most recent record per customer

-- Loading silver.crm_cust_info


