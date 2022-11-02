
WITH
  temp_2021 AS ( -- make datypes consistent and compiles August-December 2021 data using UNION ALL
    SELECT
      ride_id,
      rideable_type,
      started_at,
      ended_at,
      start_station_name,
      CAST(start_station_id AS STRING) AS start_station_id,
      end_station_name,
      CAST(end_station_id AS STRING) AS end_station_id,
      start_lat,
      start_lng,
      end_lat,
      end_lng,
      member_casual
    FROM
      (SELECT * FROM `my-data-project-359903.tripdata.202109_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202110_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202111_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202112_divvy_tripdata` 
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202201_divvy_tripdata`)
      ),
  temp_all AS (
      SELECT * FROM `my-data-project-359903.tripdata.202202_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202203_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202204_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202205_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202206_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202207_divvy_tripdata`
      UNION ALL 
      SELECT * FROM `my-data-project-359903.tripdata.202208_divvy_tripdata`
      UNION ALL
      SELECT * FROM `my-data-project-359903.tripdata.202209_divvy_tripdata`
      UNION ALL
      SELECT * FROM temp_2021
    ),
  temp_metrics AS (
    SELECT
      ride_id,
      TIMESTAMP_DIFF(ended_at, started_at, SECOND) ride_duration_second, -- to calculate the duration in second
      ST_GEOGPOINT(start_lng, start_lat) start_point,
      ST_GEOGPOINT(end_lng, start_lat) end_point,
      CASE 
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 1 THEN 'Sunday'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 THEN 'Monday'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 3 THEN 'Tuesday'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 4 THEN 'Wednesday'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 5 THEN 'Thursday'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 6 THEN 'Friday'
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 7 THEN 'Saturday'
      END AS start_day
    FROM temp_all
    )
SELECT 
  a.ride_id,
  a.rideable_type,
  m.start_day,
  a.started_at,
  a.ended_at,
  a.start_station_id,
  a.start_station_name,
  a.end_station_id,
  a.end_station_name,
  m.ride_duration_second,
  ROUND(ST_DISTANCE(m.start_point, m.end_point), 2) AS trip_distance, -- compute the distance of each trip to 2 dp.
  a.member_casual
FROM temp_all AS a
JOIN temp_metrics m
  ON a.ride_id = m.ride_id
WHERE m.ride_duration_second > 0 -- remove negative or zero duration trips
AND 
a.start_station_name IS NOT NULL -- remove null values
AND 
a.end_station_name is NOT NULL -- remove null values

-- returns 5,094,974 clean data ready for analysis