-- check for duplicate

SELECT records, COUNT(*)
FROM 
  (SELECT ride_id,COUNT(*) records
  FROM my-data-project-359903.tripdata.unclean_merged
  GROUP BY ride_id) a
WHERE a.records > 1
GROUP BY records

-- No duplicate found in the dataset