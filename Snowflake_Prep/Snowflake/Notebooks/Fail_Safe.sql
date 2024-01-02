-- FAIL SAFE 

-- Protection of historical data in case of disaster 
-- No user interaction & recoverable only by Snowflake 
-- Non-configurable 7-day period for permanent tables 
-- Contributes to storage cost 

-- Fail safe provides a non-configurable disaster recovery option after Time Travel retention period has ended. 
-- This adds to the Fail Safe Data Storage . 
-- Data can only be recovered from Fail Safe by reaching out to Snowflake Support . 
-- Transient Tables don't have any Fail Safe.  
