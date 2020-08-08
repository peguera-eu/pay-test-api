# WeatherForecast

A simple weather API made for Paggi's developer test

## How to run

  * Ensure you have docker and docker-compose
  * Run 'docker-compose up'

## Available routes

### GET /v1/cities

Returns a list of all cities.

### GET /v1/cities?top_left_lat=-38&top_left_lng=-179&bottom_right_lat=-47&bottom_right_lng=179

Returns a list of cities inside of a box set by top_left and bottom_right's coordinates.

### GET /v1/monitored_cities

Returns a list of cities that have weather information.

### GET /v1/monitored_cities/:city_id/readings

Returns the most recent reading for a given city.

### GET /v1/monitored_cities/:city_id/readings?from=2020-01-01&to=2020-12-31

Returns a list of readings from a time interval, dates must be supplied in the YYYY-MM-DD format.

## Notes

  * Some of the attributes have different names when compared to their original names, this was done to improve semantics of the data