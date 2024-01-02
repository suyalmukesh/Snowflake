DATABASE REPLICATION ( Snowflake Standard feature)
Replicates a database between accounts within the same organization 

SHARING DATA ACROSS REGIONS AND DIFFERENT CLOUD PROVIDERS ( Cross region Sharing )

Account1 (Region1) =================>  Account2(Region2)

The data is now physically extracted and copied ( Data Tranfer cost will incur)
Data and objects need to be synchronized periodically


STEP 1. Enable replication for source account with ORGADMIN role 

SHOW ORGANISATION ACCOUNTS; 

-- Enable replication for each source and target account in your organization 
SELECT SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER('organization_name'.<account_name>,
                                           'ENABLE_ACCOUNT_DATABASE_REPLICATION','true');




STEP 2: Promote a Local Database to Primary Database with ACCOUNTADMIN role 

ALTER DATABASE my_dbl ENABLE REPLICATION TO ACCOUNTS myorg.account2,myorg.account3;



STEP 3: Create Replica in consumer account 
CREATE DATABASE my_dbl AS REPLICA OF myorg.account1.my_dbl;

STEP 4: Refresh database 
ALTER DATABASE my_dbl REFRESH; 

NOTE : OWNERSHIP PRIVILEGES ARE NEEDED 

A TASK can be scheduled with this command 


