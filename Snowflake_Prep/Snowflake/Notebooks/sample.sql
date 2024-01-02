//  The Table STG_METADATA_REALASSET contains the Column Name 
//  We are trying to create a new table which will create the columns as per above table along with the datatype 
//  Will change the Stored Procedure name later 
//  For this example creating the Dynamic table as 'DynamicTable'

truncate table STG_METADATA_REALASSET

USE DATABASE PORTFOLIO_DEV_DB;
USE SCHEMA "PORTFOLIO_DEV_DB"."REALASSET_L0";



-- var my_sql_command = "select * from table1";
--    var statement1 = snowflake.createStatement( {sqlText: my_sql_command} );
--    var result_set1 = statement1.execute();
--    // Loop through the results, processing one row at a time... 
--    while (result_set1.next())  {
--       var column1 = result_set1.getColumnValue(1);
--       var column2 = result_set1.getColumnValue(2);
--       // Do something with the retrieved values...
--       }
--  return 0.0; // Replace with something more useful.
  
  
DROP PROCEDURE CreateDynamicTable_demo() 
  
  sampletable
  
CREATE OR REPLACE PROCEDURE CreateDynamicTable_demo(dynamictable VARCHAR)
RETURNS ARRAY
LANGUAGE JAVASCRIPT
AS 
$$
    var DynamicTable_demo = DYNAMICTABLE; 
    var returnset = []
   
    
    //var get_domain_name = `SELECT domain from STG_STATS_REALASSEST_REFERENCE where REPORT_ID = (select JSON_DATA:ReportId::string AS ReportId from RI_RAW_JSON)`;
    //var get_uid = `select uid from RI_RAW_JSON order by ROW_LOAD_TIME_STAMP desc limit 1 `;
    //var stmt = snowflake.createStatement({sqlText: get_domain_name});
    //var result1 = stmt.execute();
    //var stmt2 = snowflake.createStatement({sqlText:get_uid});
    //var result2 = stmt2.execute();
    
    //result1.next();
    //domain_name = result1.getColumnValue(1);
    //returnset.push(`Domain_Name : `+domain_name);
    
    //result2.next();
    //var uid = result2.getColumnValue(1);
    //var uid = uid.replace(/-/g,"");
    //returnset.push(`uid : `+uid);
    
    //DynamicTable_demo = domain_name+`_`+uid; 
    
    returnset.push(`DynamicTableName : `+DynamicTable_demo);
    
    // Declare the SQL statement to retrieve the column names
    // var getColumnsSQL = `select concat(''"'',COLUMNNAME,''"'','' '',(CASE WHEN DATATYPE in (''text'',''money'',''percent'',''note'')then ''varchar'' WHEN DATATYPE IN (''date'') THEN ''varchar'' else DATATYPE end)  )AS COL FROM  STG_METADATA_REALASSET`;

    //var getColumnsSQL = `select concat(''"'',COLUMNNAME,''"'','' '',''varchar''  )AS COL FROM  STG_METADATA_REALASSET`;
    
    var getColumnsSQL = `select concat('"',COLUMNNAME,'"', '  varchar'  )AS COL FROM  STG_METADATA_REALASSET`;
    

    suyalmukesh

    col1 string
    col2 varchar 

    json =----> variant col | uid

    transiat : loan_table_uid1 (2) 3    ---> logic to find if schema changed 

                    if yes call_alter_Schemaand load
                    else
                       simply load 

               loan_table_uid2(10)  loan_table_uid3 


    Final table(2) 10 million   : copy into final select from uid1 , select uid2 



     
    // Execute the SQL statement to retrieve the column names
    var stmt = snowflake.createStatement({sqlText: getColumnsSQL});
    var resultSet = stmt.execute();
    returnset.push(resultSet) 
    
    var columnNames = [];
    while (resultSet.next()) {
        // Store the column names in an array
        columnNames.push(resultSet.getColumnValue(1));
    }
    
    // Create the dynamic SQL statement to create the new table
    
    var createTableSQL = "CREATE OR REPLACE TABLE "+DYNAMICTABLE+" (";
    createTableSQL += columnNames.map(function(COL) {
    return COL }).join(", ");
    createTableSQL += ")"; 
    
    returnset.push(`SQL :`+createTableSQL);
    
    // Execute the dynamic SQL statement
    stmt = snowflake.createStatement({sqlText: createTableSQL});
   tableset = stmt.execute();
   returnset.push(tableset)

       
    var message = "DynamicTable2 created successfully.";
    returnset.push(message);
        return returnset; 
$$;

SELECT domain from STG_STATS_REALASSEST_REFERENCE where REPORT_ID = (select JSON_DATA:ReportId::string AS ReportId from RI_RAW_JSON)
select JSON_DATA:ReportId::string AS ReportId from RI_RAW_JSON


call CreateDynamicTable_demo(Dynamictable => 'test2');

SELECT * FROM TEST2


DROP TABLE TEST2

select * from Loan_Portfolio_Total_fc4efcce7c234a15b1f02c6d076da6bf;

select * from DynamicTable_demo;



