// Number of days for which the historical data is preserved and Time Travel can be applied 
// DEFAULT = 1
// Retention period of 0 "disables" time travel 

-- 1: Create table that overwrites default retention period 
CREATE TABLE TABLE_NAME 
(
   COL1 INT , 
   COL2 VARCHAR
)
DATA_RETENTION_TIME_IN_DAYS = 0 ; 


-- 2: Alter table's retention period 
ALTER TABLE TABLE_NAME (SET DATA_RETENTION_TIME_IN_DAYS = 0 );


-- 3: Alter account's default retention period 
ALTER ACCOUNT SET DATA_RETENTION_TIME_IN_DAYS = 2; 

-- 4: Setting minimum retention time 
ALTER ACCOUNT SET MIN_DATA_RETENTION_TIME_IN_DAYS = 2; 


-- BASED ON ACCOUNT 

-- STANDARD          -  Time Travel up to 1 day only 
-- Enterprise        -  Time Travel up to 90 Days 
-- Business Critical -  Time Travel up to 90 Days 
-- Virtual Private   -  Time Travel up to 90 days 

////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// PRACTICLES ///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////


SHOW TABLES LIKE '%emp%'
-- RETENTION_TIME will show the retention duration 


// Change Retention Period 
ALTER TABLE AZURE_INTEGRATION.EMPLOYEE_DATA.EMPLOYEE 
SET DATA_RETENTION_TIME_IN_DAYS = 0 ;


// WHILE CREATING TABLES 
CREATE OR REPLACE TABLE AZURE_INTEGRATION.EMPLOYEE_DATA.TEST_TABLE
(
  TEST_ID INTEGER,
  TEST_DATE DATE DEFAULT current_date
)
DATA_RETENTION_TIME_IN_DAYS = 3;

SHOW TABLES LIKE 'TEST_TABLE'


// ACCOUNT LEVEL 

ALTER ACCOUNT SET DATA_RETENTION_TIME_IN_DAYS = 2;

CREATE OR REPLACE TABLE AZURE_INTEGRATION.EMPLOYEE_DATA.TEST_TABLE2
(
  TEST_ID INTEGER,
  TEST_DATE DATE DEFAULT current_date
)


SHOW TABLES LIKE 'TEST_TABLE2'







