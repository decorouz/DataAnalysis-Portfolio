## Business Task
Determine how annual members and casual rider use Cyclistic differently.

## Prepare
**Data Source** 
* Public data provided by Motivate International Inc.(Divvy bike share system across Chicago and Evanston) under this [license](https://ride.divvybikes.com/data-license-agreement).
* [Download Cyclistic trip history data](https://divvy-tripdata.s3.amazonaws.com/index.html)
* The data has been processed to remove trips that are taken by staff as they service and inspect the system; and any trips that were below 60 seconds in length (potentially false starts or users trying to re-dock a bike to ensure it was secure)
* Each trip is anonymized and includes:
    * Trip start day and time
    * Trip end day and time
    * Trip start station
    * Trip end station
    * Rider type (Member, Single Ride, and Day Pass)
* **Date range**: August, 2021 to August, 2022
* All data files have the same 13 column names.

**Data Organization**
* Load all 12 files to a data store (Google Cloud Storage).
* Data imported from Google Cloud Storage into BigQuery to explore, profile, clean, shape and analyze data using SQL.
* Bind all 12 seperate files into one file using [this query](bind_query). The result returns a dataset with 13 column names and `6,584,382` rows but requires cleaning.
* Store the result of the query into a new table inside BigQuery called `bind_uncleaned_divy_data`.


## Process

* SQL in BigQuery is the tool adopted for processing because of the size of the data and need to create quick visualization.

**Data Intergrity**
* Check the ride_id for duplicate using [this query](https://github.com/decorouz/DataAnalysis-Portfolio/blob/main/Cyclistic-Case/duplicate_check.sql). It shows there is no duplicate in entire dataset.

* Check for columns that contains NULL values with this [query](https://github.com/decorouz/DataAnalysis-Portfolio/blob/main/Cyclistic-Case/columns_null_check.sql). The dataset has no missing values for `ride_id`, `rideable_type`, `start_lat`, `start_lng`, `started_at`, `ended_at` but lack data in `start_station_name`, `start_station_id`, `end_station_name`, `end_station_id`,  `end_lat`, `end_lng`. -> Need to clean theses variables before proceeding with analysis.

    ![image](Cyclistic-Case/viz/column_null_summary.png)
    - A total of `1,489,091` records contain missing/NULL values. [Query](https://github.com/decorouz/DataAnalysis-Portfolio/blob/main/Cyclistic-Case/columns_check.sql).  
    * Using [this query](https://github.com/decorouz/DataAnalysis-Portfolio/blob/main/Cyclistic-Case/check_null.sql) `start_station_name` and `end_station_name` are found to account for `15.01%` and `16.06%` of the missing value respectively.
    * The electric bike type is found to have `31.33%` missing `start_station_name` values compared to the zero percent for other bike types using [this query](https://github.com/decorouz/DataAnalysis-Portfolio/blob/main/Cyclistic-Case/check_null.sql).

**Cleaning Goals**
Remove irrevant trips
- Trips to and from repair centers or depot
- Trips that vanishes at the end(no end_station_name and end_lat/end_lng). Assume bike is stolen or damaged.
- Round trips that are too short. Definition: Trips that starts and end at the same station and are more than 60 sec.
- purge all columns with NULL end_lat, end_lng
- Purge all negative duration
- Purge all columns with repair centers

**Data Cleaning Process**:

>**Outlier** 
* Perform statistical summary with [this query](query). The maximum trip distance in meters `1078175.84`m appears to be an outlier. Let's investigate with this [query](query)

>**Missing Data Strategy:** The dataset contains `1,489,091` records with missing values. This amount to `16%` of the entire dataset. A [litewise deletion](https://humansofdata.atlan.com/2017/09/4-methods-missing-data/) strategy is adopted because we do still have sufficient data to perform the analysis. Also the variables that contains the missing values are not important in deriving insight per the business task under investigation.


**Summary**
* Upon cleaning the data, `5,094,974` rows will be used for further analysis.





## Analyze
* Create a new variable/column `ride_duration_second` to calculate the duration of each ride by subtracting the column `started_at` from the column `ended_at` and format in second.
* Create a new variable/column `ride_distance` to calculate the distance of each ride by using spatial relation functions `ST_GEOGPOINT`, `ST_DISTANCE` on the `start_lgn` `start_lat`, and `end_lng`, `end_lat`.
* Profile the day name of the `start_at` timestamp as `start_day`.






