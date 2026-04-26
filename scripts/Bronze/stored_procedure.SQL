
-- if we need to update the data in the tables frequently then create "Stored Procedure"

-- Below line is defining a reusable stored procedure called load_Bronze in the Bronze schema. 
-- Once you add the bulk insert logic inside it, 
-- you’ll be able to reload all your bronze tables with one command


CREATE or ALTER Procedure Bronze.load_Bronze AS
BEGIN
    DECLARE @START_TIME DATETIME, @END_TIME DATETIME, @BATCH_START_TIME DATETIME, @BATCH_END_TIME DATETIME
    BEGIN TRY
        SET @BATCH_START_TIME = GETDATE()
        PRINT '=====================================';
        PRINT 'Loading the Bronze Layer';
        PRINT '=====================================';


        PRINT '=====================================';
        PRINT 'Loading the CRM TABLES with Data';
        PRINT '=====================================';


        SET @START_TIME = GETDATE();
        PRINT '>> Truncate Table: Bronze.crm_cust_info'
        TRUNCATE TABLE Bronze.crm_cust_info;
        PRINT '>> Inserting Data into Table: Bronze.crm_cust_info'
        BULK INSERT Bronze.crm_cust_info
        From 'C:\Users\Praveen\Documents\Machiine Learning\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv '
        with(
        FirstRow =2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration :' + CAST(datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
        PRINT '>>....................'


        SET @START_TIME = GETDATE();
        PRINT '>> Truncate Table: Bronze.crm_prd_info'
        TRUNCATE TABLE Bronze.crm_prd_info;
        PRINT '>> Inserting Data into Table: Bronze.crm_prd_info'
        BULK INSERT Bronze.crm_prd_info
        From 'C:\Users\Praveen\Documents\Machiine Learning\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv '
        with(
        FirstRow =2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration :' + CAST (datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
        PRINT '>>....................'


        SET @START_TIME = GETDATE();
        PRINT '>> Truncate Table: Bronze.crm_sales_details'
        TRUNCATE TABLE Bronze.crm_sales_details;
        PRINT '>> Inserting Data into Table: Bronze.crm_sales_details'
        BULK INSERT Bronze.crm_sales_details
        From 'C:\Users\Praveen\Documents\Machiine Learning\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv '
        with(
        FirstRow =2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration :' + CAST (datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
        PRINT '>>....................'

  
        PRINT '=====================================';
        PRINT 'Loading the ERP TABLES with Data';
        PRINT '=====================================';


        SET @START_TIME = GETDATE();
        PRINT '>> Truncate Table: Bronze.crm_prd_info'
        TRUNCATE TABLE Bronze.erp_cust_az12;
        PRINT '>> Inserting Data into Table: Bronze.crm_prd_info'
        BULK INSERT Bronze.erp_cust_az12
        From 'C:\Users\Praveen\Documents\Machiine Learning\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        with(
        FirstRow =2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration :' + CAST (datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
        PRINT '>>....................'


        SET @START_TIME = GETDATE();
        PRINT '>> Truncate Table: Bronze.erp_loc_a101'
        TRUNCATE TABLE Bronze.erp_loc_a101;
        PRINT '>> Inserting Data into Table: Bronze.erp_loc_a101'
        BULK INSERT Bronze.erp_loc_a101
        From 'C:\Users\Praveen\Documents\Machiine Learning\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        with(
        FirstRow =2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration :' + CAST (datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
        PRINT '>>....................'


        SET @START_TIME = GETDATE();
        PRINT '>> Truncate Table: Bronze.erp_px_cat_g1v2'
        TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting Data into Table: Bronze.erp_px_cat_g1v2'
        BULK INSERT Bronze.erp_px_cat_g1v2
        From 'C:\Users\Praveen\Documents\Machiine Learning\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        with(
        FirstRow =2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @END_TIME = GETDATE();
        PRINT '>> Load Duration :' + CAST (datediff(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
        PRINT '>>....................'

        SET @BATCH_END_TIME = GETDATE()
        PRINT '=====================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT 'Total Load Duration :' + cast(datediff(second,@BATCH_START_TIME, @BATCH_END_TIME) AS NVARCHAR) + ' seconds'
        PRINT '=====================================';

    END TRY
    BEGIN CATCH
    PRINT '====================================================='
    PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
    PRINT 'Error Message' + Error_Message();
    PRINT 'Error Message' + CAST(Error_Number() AS NVARCHAR);
    PRINT 'Error Message' + CAST(Error_State() AS NVARCHAR);
    PRINT '====================================================='
    END CATCH

END

-- Below is the single command that helps in running all the table updates above at once

execute bronze.load_Bronze
