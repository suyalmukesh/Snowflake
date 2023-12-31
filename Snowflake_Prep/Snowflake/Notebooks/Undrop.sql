SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA;

// WE AE DOING AN ACCIDENTAL UPDATE WHICH WE REALISE WAS INCORRECT 
UPDATE TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA
SET ENAME = 'MUKESH CHANDRA SUYAL';

-- NOW WE NEED TO RESTORE OUR TABLE 

/// /// /// Restoring (Good Method)  /// /// ///

-- 1.  USING TIMETRAVEL , WE WILL FIRST CREATE A BACKUP TABLE HAVING THE DATA BEFORE THE UPDATE ( INTERMEDIATE TABLE )
-- 2.  WILL TRUNCATE THE ORIGINAL TABLE 
-- 3.  WILL INSERT TO ORIGINAL TABLE USING BACKUP TABLE 

// BACKUP TABLE 
CREATE OR REPLACE TABLE TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_BACKUP AS 
SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA BEFORE (STATEMENT => '01aca098-0001-2059-0003-f9220001617a');

SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_BACKUP;


// TRUNCATE ORIGINAL TABLE 
TRUNCATE TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA;


// INSERT DATA INTO ORIGINAL TABLE 
INSERT INTO TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA
SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_BACKUP;


// UNDROP 

// CREATE A NEW STAGE 
CREATE OR REPLACE STAGE TIMETRAVEL.EXTERNAL_STAGES.UNDROP_TEST
URL = 'azure://azuresnowflakecoupling.blob.core.windows.net/timetravel'
STORAGE_INTEGRATION = azure_integration
FILE_FORMAT = MANAGE_DB.PUBLIC.FLEFORMAT_AZURE;

LIST @TIMETRAVEL.EXTERNAL_STAGES.UNDROP_TEST;

CREATE OR REPLACE TABLE TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST
(
EMPNO STRING,
ENAME STRING,
JOB STRING,
MGR STRING,
HIREDATE string,
SAL STRING,
COMM STRING,
DEPTNO STRING,
UPDATED_DATE string
);  


COPY INTO TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST
FROM @TIMETRAVEL.EXTERNAL_STAGES.UNDROP_TEST
FILES = ('emp.csv');

SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST;


// DROP TABLE 
DROP TABLE TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST;

SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST;

//UNDROP 
UNDROP TABLE TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST;
SELECT * FROM TIMETRAVEL.EMP_SENSITIVE_DATA.EMP_DATA_UNDROP_TEST;


// DROP/UNDROP SCHEMA 

DROP SCHEMA TIMETRAVEL.EMP_SENSITIVE_DATA;

UNDROP SCHEMA TIMETRAVEL.EMP_SENSITIVE_DATA;



//DROP/UNDROP THE WHOLE DATABASE 

DROP DATABASE TIMETRAVEL;
USE DATABASE TIMETRAVEL; -- WILL LEAD TO ERROR 


UNDROP DATABASE TIMETRAVEL;
