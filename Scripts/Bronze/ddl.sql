Create Database Warehouse;
Use Warehouse
Create SCHEMA bronze;
Create Schema silver;
Create Schema gold;

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_material_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt TIMESTAMP,
    prd_end_dt TIMESTAMP
);
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

CREATE TABLE bronze.erp_loc_a101(
cid VARCHAR(50),
cntry VARCHAR(50)
);

CREATE TABLE bronze.erp_cust_az12(
cid VARCHAR(50),
bdate Date,
gen VARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2(
id VARCHAR(50),
cat VARCHAR(50),
subcat VARCHAR(50),
maintenance VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_material_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

DROP TABLE IF EXISTS bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt TIMESTAMP,
    prd_end_dt TIMESTAMP
);

SELECT *
FROM bronze.crm_cust_info
LIMIT 10;
SELECT COUNT(*)FROM bronze.crm_cust_info

SELECT *
FROM bronze.crm_prd_info
LIMIT 10;
SELECT COUNT(*)FROM bronze.crm_prd_info


SELECT *
FROM bronze.erp_cust_az12
LIMIT 10;
SELECT COUNT(*)FROM bronze.erp_cust_az12

SELECT *
FROM bronze.erp_loc_a101
LIMIT 10;
SELECT COUNT(*)FROM bronze.erp_loc_a101
SELECT *
FROM bronze.erp_loc_a101
LIMIT 10;
SELECT COUNT(*)FROM bronze.erp_loc_a101
 HOW TO DELETE ABOVE TABLE
TRUNCATE TABLE bronze.erp_loc_a101;
SELECT COUNT(*)
FROM bronze.erp_loc_a101;

 SELECT  COUNT(*)FROM bronze.crm_sales_details
 SELECT COUNT(*)FROM bronze.crm_cust_info
 SELECT  COUNT(*)FROM bronze.crm_prd_info
SELECT  COUNT(*)FROM bronze.erp_cust_az12
SELECT  COUNT(*)FROM bronze.erp_loc_a101
SELECT  COUNT(*)FROM bronze.erp_px_cat_g1v2
