--   EXPERIMENT 1 => JSON & LATERAL FLATTEN FUNCTIONS  

USE DATABASE JSON_DATA;

USE SCHEMA JSON_SCHEMA;


-- STEP 1 :  CREATE A SNOWFLAKE INTERNAL NAMED STAGE 

CREATE OR REPLACE STAGE my_internal_stage_for_json;

-- STEP 2 :  LOAD DATA FROM LOCAL MACHINE TO THIS INTERNALE STAGE 
-- USING SNOWSQL EXECUTE THIS COMMAND :  
-- ****   PUT file:///Users/mukesh/desktop/authors.json @~/my_internal_stage_for_json;  ****

-- STEP 3 : VERIFY THE FILE IN INTERNAL STAGE USNG LIST COMMAND 

LIST @~/my_internal_stage_for_json;

-- STEP 4 : LOADING JSON DATA FROM INTERNAL STAGE INTO DATABASE TABLE 

-- CREATE JSON FILE FORMAT AS 
CREATE OR REPLACE FILE FORMAT JSON_TYPE 
    TYPE = 'json'
    STRIP_OUTER_ARRAY = TRUE;
-- Why strip_outer_array - to remove '[]'

-- STEP 5 : CREATE DATABASE TABLE TO LOAD JSON DATA 

CREATE OR REPLACE TABLE AUTHORS 
(
   JSON_DATA VARIANT
);

-- STEP 6 : LOAD DATA FROM INTERNAL STAGE TO THIS DATABASE TABLE USING COPY COMMAND 

COPY INTO AUTHORS 
FROM @~/my_internal_stage_for_json
FILE_FORMAT = (FORMAT_NAME = JSON_TYPE);

-- STEP 7 : QUERING JSON DATA FROM THIS TABLE 

SELECT * FROM AUTHORS;

-- STEP 8 : QUERY SOME INDIVIDUAL COLUMNS 
SELECT JSON_DATA:AuthorName, JSON_DATA:Category from AUTHORS;

-- STEP 9 : THE DATA IN CATEGORY COLUMN CAN BE FURTHER DRILLED DOWN AS 

SELECT JSON_DATA:AuthorName,
       JSON_DATA:Category[0]:CategoryName,
       JSON_DATA:Category[1]:CategoryName
FROM AUTHORS;       

-- Step 10 : Remove the outer Quotes 

SELECT JSON_DATA:AuthorName::string,
       JSON_DATA:Category[0]:CategoryName::string,
       JSON_DATA:Category[1]:CategoryName::string
FROM AUTHORS;       

-- STEP 11 : MORE DETAILS CAN BE FETCHED AS 
SELECT 
    JSON_DATA:AuthorName::string,
    JSON_DATA:Category[0]:CategoryName::string,
    JSON_DATA:Category[0]:Genre[0]:GenreName::string,
    JSON_DATA:Category[0]:Genre[1]:GenreName::string,
    JSON_DATA:Category[1]:CategoryName::string,
    JSON_DATA:Category[1]:Genre[0]:GenreName::string,
    JSON_DATA:Category[1]:Genre[1]:GenreName::string
FROM Authors;

-- UNFORTUNATELY THE ABOVE APPROACH IS NOT IDEAL BECAUSE AS THE DATA INCREASES , WE NEED TO ADD ADDITIONAL LEVELS 
-- OF CATEGORY IN THE QUERY STATEMENT 

-- ******************************************************************************************************************
-- //// **********   FLATTENING ARRAYS IN JSON DATA **********  //////  

-- Flattening is a process of unpacking the semi-structured data into a columnar format by converting arrays into -- --different rows of data.

SELECT JSON_DATA:AuthorName::string AS Author, 
       VALUE:CategoryName::string as CategoryName,
       VALUE:Genre::string as Genre
FROM AUTHORS,
LATERAL FLATTEN(INPUT => JSON_DATA:Category); 

-- We have more columns to flatten Category , Genre and Novel to get the desired output . 

-- Also note , Novel array is present inside Genre array which is present inside Category array . 
-- So the flattened array output VALUE becomes input for the array present inside it . 

SELECT 
       JSON_DATA:AuthorName::string as AuthorName, 
       Flatten_Category.VALUE:CategoryName::string AS Category_Name,
       Flatten_Genre.VALUE:GenreName::string AS Genre_Name,
       Flatten_Novel.VALUE:Novel::string AS Novel_Name,
       Flatten_Novel.VALUE:Sales::string AS Sales_in_Millions
FROM AUTHORS 
,LATERAL FLATTEN(INPUT => JSON_DATA:Category) AS Flatten_Category
,LATERAL FLATTEN(INPUT => Flatten_Category.VALUE:Genre) AS Flatten_Genre
,LATERAL FLATTEN(INPUT => Flatten_Genre.VALUE:Novel) AS Flatten_Novel
;

//////////////////////////////////////////////////////////////////////////////////////////////////

-- Reading source : https://thinketl.com/how-to-load-and-query-json-data-in-snowflake/ 





        





