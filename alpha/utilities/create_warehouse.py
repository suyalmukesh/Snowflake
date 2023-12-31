CREATE_WH = """CREATE WAREHOUSE IF NOT EXISTS SUYAL_WH
                      WAREHOUSE_SIZE = 'XSMALL'
                      AUTO_SUSPEND = 300
                      AUTO_RESUME = TRUE;"""

ALTER_WH = """
            ALTER WAREHOUSE SUYAL_WH
                  WAREHOUSE_SIZE = 'XSMALL'
                  AUTO_SUSPEND = 300
                  AUTO_RESUME = TRUE;
            """

