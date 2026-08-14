/*
===============================================================================
Stored Procedure: Validate Bronze Layer
===============================================================================
Purpose:
    Checks the data already loaded into the Bronze layer.

    It:
    - Counts records in each Bronze table
    - Displays the row count for CRM and ERP tables
    - Calculates the total number of records
    - Shows the execution duration

Note:
    CSV files have already been imported through pgAdmin 4.
===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.validate_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_end_time TIMESTAMP;
    v_total_rows BIGINT;
BEGIN

    v_start_time := clock_timestamp();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Validating Bronze Layer';
    RAISE NOTICE '================================================';

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'CRM Tables';
    RAISE NOTICE '------------------------------------------------';

    RAISE NOTICE 'crm_cust_info: % rows',
        (SELECT COUNT(*) FROM bronze.crm_cust_info);

    RAISE NOTICE 'crm_prd_info: % rows',
        (SELECT COUNT(*) FROM bronze.crm_prd_info);

    RAISE NOTICE 'crm_sales_details: % rows',
        (SELECT COUNT(*) FROM bronze.crm_sales_details);

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'ERP Tables';
    RAISE NOTICE '------------------------------------------------';

    RAISE NOTICE 'erp_loc_a101: % rows',
        (SELECT COUNT(*) FROM bronze.erp_loc_a101);

    RAISE NOTICE 'erp_cust_az12: % rows',
        (SELECT COUNT(*) FROM bronze.erp_cust_az12);

    RAISE NOTICE 'erp_px_cat_g1v2: % rows',
        (SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2);

    SELECT
        (SELECT COUNT(*) FROM bronze.crm_cust_info) +
        (SELECT COUNT(*) FROM bronze.crm_prd_info) +
        (SELECT COUNT(*) FROM bronze.crm_sales_details) +
        (SELECT COUNT(*) FROM bronze.erp_loc_a101) +
        (SELECT COUNT(*) FROM bronze.erp_cust_az12) +
        (SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2)
    INTO v_total_rows;

    v_end_time := clock_timestamp();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Bronze Layer Validation Completed';
    RAISE NOTICE 'Total Records: %', v_total_rows;
    RAISE NOTICE 'Total Duration: % seconds',
        ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time))::NUMERIC, 2);
    RAISE NOTICE '================================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '================================================';
        RAISE NOTICE 'ERROR OCCURRED DURING BRONZE VALIDATION';
        RAISE NOTICE 'Error Message: %', SQLERRM;
        RAISE NOTICE '================================================';
END;
$$;

-- Execute the procedure
CALL bronze.validate_bronze();
