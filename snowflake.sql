show databases;

create or replace database alpha;


use alpha;


CREATE WAREHOUSE IF NOT EXISTS SUYAL_WH
                      WAREHOUSE_SIZE = 'XSMALL'
                      AUTO_SUSPEND = 300
                      AUTO_RESUME = TRUE;