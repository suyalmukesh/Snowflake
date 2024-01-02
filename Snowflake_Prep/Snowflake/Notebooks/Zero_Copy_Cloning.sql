--  ZERO-COPY CLONING 

--  VERY SIMPLE SYNTAX 

CREATE TABLE NEW_TABLE CLONE TABLE_SOURCE; 

-- CLONING CAN ALSO BE DONE FOR => DATABASE | SCHEMA | TABLE | STREAM | FILE FORMAT | SEQUENCE | STAGE | TASK | PIPE 

-- PIPE CAN ONLY BE CLONED IF IT REFERENCES EXTERNAL STAGES 

-- STAGES - NAMED INTERNAL STAGES CAN NOT BE CLONED 

-- Cloning a database or schema will clone all contained objects 

--  NOTES : 

/*

1. Creates copies of a DATABASE , a SCHEMA or a TABLE ( Basically a metadata operation ). 
   Both the original & cloned table will reference the same micro-partitions. 
   Both the tables are independent from each other . 
   Question : If the tables referencing the same micro-partitions then how the updated/inserts are independent ? 
   Answer : When a update or Insert happens on any table , new micro-partitions will be craeted . So this way it is storage efficient . 

2. Cloned object is independent from original table 

3. Easy to copy all meta data & improved storage management . 

4. Useful for creating backups for development purposes . 

5. Typically combined with Time Travel 

*/

How about privileges ? 

Privileges will always only be inherited to child objects never to source object itself . 


What privileges are needed ? 

For "table" - SELECT privileges are needed 

For "PIPE | STREAM | TASK"  OWNER privileges are needed 

For "all other objects" USAGE privileges are needed 


Additional Considerations 

1. Load History metadata is not copied ( Loaded data can be loaded again )

2. Cloning from specific point in time is possible 

CREATE TABLE TABLE_NEW 
CLONE TABLE_SOURCE 
BEFORE (TIMESTAMP => 'TIMESTAMP')



//////// PRACTICLES ////////////////////////////////////////////////////////////////////////////

CREATE DATABASE TIMETRAVEL_CLONE CLONE TIMETRAVEL; 





















