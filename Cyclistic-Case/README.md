## Business Task
Determine how annual members and casual rider use Cyclistic differently.

## Data Source
* **Data Source:** Public data provided by Motivate International Inc.(Divvy bike share system across Chicago and Evanston) under this [license](https://ride.divvybikes.com/data-license-agreement).
* [Download Cyclistc trip history data](https://divvy-tripdata.s3.amazonaws.com/index.html)
* The data has been processed to remove trips that are taken by staff as they service and inspect the system; and any trips that were below 60 seconds in length (potentially false starts or users trying to re-dock a bike to ensure it was secure)
* Each trip is anonymized and includes:
    * Trip start day and time
    * Trip end day and time
    * Trip start station
    * Trip end station
    * Rider type (Member, Single Ride, and Day Pass)
* **Date range**: September 2021 to September 2022
* Download the data to local storage

## Cleaning, Processing and Manipulation of Data
* Extract data from zip file on local storage
* Load data to a data store (Google Cloud Storage).
* Data imported from Google Cloud Storage into BigQuery to explore, profile, clean, shape and analyze data using SQL.
* SQL in BigQuery is used the tool for this analysis because of the size of the data and need to create quick visualization.
* Create a new variable/column `ride_duration_second` to calculate the duration of each ride by subtracting the column `started_at` from the column `ended_at` and format in second.
* Create a new variable/column `ride_distance` to calculate the distance of each ride by using spatial relation functions `ST_GEOGPOINT`, `ST-DISTANCE` on the `start_lgn` `start_lat`, and `end_lng`, `end_lat`.
* Profile the day name of the `start_at` timestamp as `start_day`.
* Save the result of the 


* **Cleaning Process**:
    - Rename downloaded file to ensure filename consistence 
    - Check for duplication using [this query](duplicate)
    - Checking for missing `start_station_name`, `start_station_id`, `end_station_name`, `end_station_id` using [this query](missing_name).
    - Check for missing `NULL` values using [this query](null_check)


## Summary of analysis
## Visualization. (Chart, Dashboard)
## Recommendation