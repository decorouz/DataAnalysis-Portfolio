
/* ---------------------
Check for columns that contains NULL or missing values in the dataset
----------------------- */

SELECT *
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata` t
WHERE REGEXP_CONTAINS(TO_JSON_STRING(t), r':(?:null|"")[,}]');

-- start_station_id, 
-- start_station_name, 
-- end_station_id, 
-- end_station_name


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
  
/* ---------------------
Null row count
----------------------- */

SELECT COUNT(*) null_rows
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata` t
WHERE REGEXP_CONTAINS(TO_JSON_STRING(t), r':(?:null|"")[,}]');

-- Returns 1,489,091 rows