# Sweater Weather

### Background and Description

"Sweater Weather" is a school assigned backend API only application that handles request from a ficticious front end application that needs weather forecasts at destinations for road trips, along the way fetching background images, user registration, and authentication.

### Goals accomplished
- Consumed MapQuest API for geo-location latitude, longitude, and trip travel time 
- Consumed OpenWeather API for one call forecast at specified locations
- Consumed Unsplash API for background images searches
- Implemented code structure that adheres to SRP
- Untangle nested hashes to serialize and pass required information to front end
- Setup user database and sessions to authentication users in the front end


## Versions

- Ruby 2.5.3

- Rails 5.2.4.5


## Getting Started

### Installation

1. Fork and Clone the repo
   ```
   git clone git@github.com:ninesky00/sweater-weather.git
   ```
2. Install gems
   ```
   bundle install
   ```
3. Setup the database: 
   ```
   rails db:setup
   ```

## Endpoints
[sample data](media/sweater_weather.json)
all end points are expecting raw json payload requests

#### User Registration
post `/api/v1/users` ex. {"email": "test2@gmail.com", "password": "test2", "password_confirmation": "test2"}

#### User Authentication
post `/api/v1/sessions` ex. {"email": "test2@gmail.com", "password": "test2"}

#### Forecast
get `/api/v1/forecast` ex. {"location": "denver, CO"}

#### Background Image
get `/api/v1/backgrounds` ex. {"location": "denver, colorado"}

### Road Trip
post `/api/v1/road_trip` ex. {"origin": "Denver, CO", "destination": "Pueblo, CO", "api_key": "5c0db1b400c236895656eebc738cf48f8b873435"}  
api_key is provided upon successful user registration



### Project Details
[Turing School](https://backend.turing.io/module3/projects/sweater_weather/requirements)