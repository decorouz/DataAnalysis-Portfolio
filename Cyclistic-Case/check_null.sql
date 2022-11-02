
/* ---------------------
Percentage of Missing Data
----------------------- */
 
-- Percentage of missing values by columns
SELECT 
  100.0 * SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS start_station_perc,
  100.0 * SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS end_station_perc,
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata`;

-- Percentage of missing values by ridetype to 2 decimal places
SELECT rideable_type,
  ROUND(100.0 * SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS start_station_perc,
  ROUND(100.0 * SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS end_station_perc,
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata`
GROUP BY rideable_type;

-- Percentage of Missing values by ridetype and member
SELECT rideable_type, member_casual,
  100.0 * SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS start_station_perc,
  100.0 * SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) / COUNT(*) AS end_station_perc,
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata`
GROUP BY rideable_type, member_casual
ORDER BY start_station_perc;

-- Percentage of missing values by member type
SELECT member_casual,
  (COUNT(*) - COUNT(start_station_name)) * 100 / COUNT(*) start_station_perc,
  (COUNT(*) - COUNT(end_station_name)) * 100 / COUNT(*) end_station_perc
FROM `my-data-project-359903.tripdata.uncleaned_merged_tripdata`
GROUP BY member_casual;



