-- PERMANENT TABLES ( Permanent data )

SYNTAX      :  CREATE TABLE .... 
TIME TRAVEL :  TIME TRAVEL RETENTION PERIOD 0-90 DAYS 
FAIL SAFE   :  FULL SAFE 
PERSISTANCE :  Until Dropped 


-- TRANSIENT TABLES ( Large tables that does not need to be protected )

SYNTAX      :  CREATE TRANSIENT TABLE .... 
TIME TRAVEL :  0 OR 1 DAY 
FAIL SAFE   :  NOT SUPPORTED 
PERSISTANCE :  Until Dropped 
We can save costs here if our data need not to be protected 

-- TEMPORARY TABLES  ( only for Non-Permanent data )

SYNTAX      :  CREATE TEMPORARY TABLE .... 
TIME TRAVEL :  0 OR 1 DAY 
FAIL SAFE   :  NOT SUPPORTED 
PERSISTANCE :  None . The table persist only in the session 

-- So by choosing the Table Types , we can manage the storage costs 


-- TABLE TYPES NOTES 

--  1.  Types are also available for other database objects =>  | TABLES | STAGES | SCHEMA | DATABASE |
--      ( If database is transient all included objects are transient )

--  2.  For temporary table no naming conflicts with permanent/transient tables 
--      Other tables will be effectively hidden ! Relevant for time travel 
--      Not visible for other users ! 

--  3.  Not possible to change type of object for existing object 



