
/* ---------------------
Station column check
----------------------- */

SELECT COUNT(*) null_count,
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata`
WHERE 
  start_station_name IS NULL
  OR
  end_station_name IS NULL;
  -- Returns 1,489,091 missing station info



/* ---------------------
Other column check
----------------------- */
SELECT *
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata`
WHERE 
  start_day IS NULL
  OR
  started_at IS NULL
  OR 
  ended_at IS NULL
  OR
  member_casual IS NULL
  -- No null values
  