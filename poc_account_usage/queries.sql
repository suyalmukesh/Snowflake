USE DATABASE ALPHA;

select * from information_schema.VIEWS;


SELECT
  query_id,
  start_time,
  end_time,
  status,
  error_message,
  statement_text
FROM
  SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
ORDER BY
  start_time DESC
LIMIT 10;

