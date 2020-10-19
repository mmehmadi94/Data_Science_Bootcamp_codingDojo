
###########   Relational Data Ch13: Excerices soluation of R for Data Science  ################

library("tidyverse")
library("nycflights13")
library("viridis")
library("datamodelr")

# 13.2.1 Exercises --------------------------------------------------------


# 1- Imagine you wanted to draw (approximately) the route each plane flies from its origin to its destination.
# What variables would you need? What tables would you need to combine?
 
   # Answer: Drawing the routes requires the latitude and longitude of the origin and the destination airports of each flight.
  # This requires to ineer join the flights and airports tables. The flights table has the origin (origin) and destination (dest) airport of each flight. 
  # The airports table has the longitude (lon) and latitude (lat) of each airport.


# 2- I forgot to draw the relationship between weather and airports. 
# What is the relationship and how should it appear in the diagram?

  # Answer: The column airports$faa is a foreign key of weather$origin

# 3 - weather only contains information for the origin (NYC) airports.
# If it contained weather records for all airports in the USA, what additional relation would it define with flights?
  
  # Answer: it would provide the weather for the destination of each flight
  # The weather data frame columns (year, month, day, hour, origin) are a foreign key for the flights
  # data frame columns (year, month, day, hour, dest).

# 4- We know that some days of the year are “special”, and fewer people than usual fly on them.
# How might you represent that data as a data frame? What would be the primary keys of that table?
# How would it connect to the existing tables?

  # I would add a table of special dates, similar to the following table.

special_days <- tribble(
  ~year, ~month, ~day, ~holiday,
  2013, 01, 01, "New Years Day",
  2013, 07, 04, "Independence Day",
  2013, 11, 29, "Thanksgiving Day",
  2013, 12, 25, "Christmas Day"
)
  # The primary key of the table would be the (year, month, day) columns



# 13.3.1 Exercises --------------------------------------------------------

# 1- Add a surrogate key to flights.
# generate flight_id column as a surrogate key after sorting 
flights <- flights %>%
  arrange(year, month, day, sched_dep_time, carrier, flight) %>%
  mutate(flight_id = row_number()) %>%
  glimpse()

# 2- Identify the keys in the following datasets
# Lahman::Batting,
Lahman::Batting %>%
  count(playerID, yearID, stint) %>%
  filter(n > 1) %>%
  nrow()
#> [1] 0

# babynames::babynames
install.packages("babynames")

# The primary key for babynames::babynames is (year, sex, name).
# The columns (year, name) are not a primary key since there are separate counts for each name for each sex, and the same names
# can be used by more than one sex
babynames::babynames %>%
  count(year, sex, name) %>%
  filter(n > 1) %>%
  nrow()

# nasaweather::atmos
install.packages("nasaweather")

# The primary keies are lat, long, year, month.  lat, long columns are unique identifiers 
nasaweather::atmos %>%
  count(lat, long, year, month) %>% 
  filter(n > 1) %>%
  nrow()
#> [1] 0

# fueleconomy::vehicles
install.packages("fueleconomy")


# ggplot2::diamonds

  # Answer: Since there are duplicate rows so we need a unique identifier for our analysis, we could add a surrogate key.
diamonds <- mutate(ggplot2::diamonds, id = row_number())

# 3- Draw a diagram illustrating the connections between the Batting, People, and Salaries tables in the Lahman package.
# Draw another diagram that shows the relationship between People, Managers, AwardsManagers.
# How would you characterise the relationship between the Batting, Pitching, and Fielding tables?


Lahman::Batting
Lahman::People
Lahman::Salaries

Lahman::People %>%
  count(playerID) %>% 
  filter(n > 1) %>%
  nrow()

# People
# Primary key: playerID

# Batting
# Primary key: playerID, yearID, stint
# Foreign keys: playerID = People$playerID (many-to-1)

# Salaries
# Primary key: yearID, teamID, playerID
# Foreign keys: playerID = People$playerID (many-to-1)



# 13.4.6 Exercises --------------------------------------------------------

#1-Compute the average delay by destination, then join on the airports data frame so you can show the 
# spatial distribution of delays. Here’s an easy way to draw a map of the United States:

#(Don’t worry if you don’t understand what semi_join() does — you’ll learn about it next.)
#You might want to use the size or colour of the points to display the average delay for each airport.

  airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# group the flight column by dest then calculate average delay 
# then join with airport table to get lat/ long columns
avg_dest_delays <-
  flights %>%
  group_by(dest) %>%
  # arrival delay NA's are cancelled flights
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c(dest = "faa"))

avg_dest_delays %>%
  ggplot(aes(lon, lat, colour = delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()


# 2- Add the location of the origin and destination (i.e. the lat and lon) to flights.

airport_locations <- airports %>%
  select(faa, lat, lon)

flights <- flights %>%
left_join(airport_locations, by = c(dest = "faa")) %>%
left_join(airport_locations, by = c(origin = "faa"), suffix = c("_origin", "_dest"))


# 3-Is there a relationship between the age of a plane and its delays?
plane_cohorts <- inner_join(flights,
                            select(planes, tailnum, plane_year = year),
                            by = "tailnum") %>%
  mutate(age = year - plane_year) %>%
  filter(!is.na(age)) %>%
  mutate(age = if_else(age > 25, 25L, age)) %>%
  group_by(age) %>%
  summarise(
    dep_delay_mean = mean(dep_delay, na.rm = TRUE),
    dep_delay_sd = sd(dep_delay, na.rm = TRUE),
    arr_delay_mean = mean(arr_delay, na.rm = TRUE),
    arr_delay_sd = sd(arr_delay, na.rm = TRUE),
    n_arr_delay = sum(!is.na(arr_delay)),
    n_dep_delay = sum(!is.na(dep_delay))
  )
#> `summarise()` ungrouping output (override with `.groups` argument)
  
# 4- What weather conditions make it more likely to see a delay?
flight_weather <- flights %>%
  left_join(weather, by = c(    "origin" = "origin",
                                "year" = "year",
                                "month" = "month",
                                "day" = "day",
                                "hour" = "hour"))
flight_weather %>%
  group_by(precip) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = precip, y = delay)) +
  geom_line() + geom_point()
#> `summarise()` ungrouping output (override with `.groups` argument)

# Answer: There seems to be a stronger relationship between visibility and delay. Delays are higher when visibility is less than 2 miles.

# 5- What happened on June 13 2013? Display the spatial pattern of delays, 
#and then use Google to cross-reference with the weather.

# There was a large series of storms (derechos) in the southeastern US 

flight_weather %>%
  filter(year == 2013) %>%
  group_by(month) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = month , y = delay)) +
  geom_line() 
  
flights %>%
  filter(year == 2013, month == 6, day == 13) %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  ggplot(aes(y = lat, x = lon, size = delay, colour = delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap() 


# 13.5.1 Exercises --------------------------------------------------------

# 1- What does it mean for a flight to have a missing tailnum?
# What do the tail numbers that don’t have a matching record in planes have in common? 
# (Hint: one variable explains ~90% of the problems.)

# Answer:Flights that have a missing tailnum all have missing values of arr_time, meaning that the flight was canceled.

flights %>%
  filter(is.na(tailnum), !is.na(arr_time)) %>% # there is no flight with empty tailnum and has arr time 
  nrow()
#> [1] 0


# 2- Filter flights to only show flights with planes that have flown at least 100 flights.
 
# No need to merge two tables. We use join just if we need info from both tables                          
flight_planes <- flights %>%
  filter(!is.na(tailnum)) %>%
  group_by(tailnum) %>%
  count() %>%
  filter(n >= 100)


# 3- Combine fueleconomy::vehicles and fueleconomy::common to find only the records 
# for the most common models.

fueleconomy::vehicles %>%
  semi_join(fueleconomy::common , by = c("make", "model"))

# 4- Find the 48 hours (over the course of the whole year) that have the worst delays. 
# Cross-reference it with the weather data. Can you see any patterns?

worst_hours <- flights %>%
  mutate(hour = sched_dep_time %/% 100) %>%
  group_by(origin, year, month, day, hour) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(dep_delay)) %>%
  slice(1:48)
#> `summarise()` regrouping output by 'origin', 'year', 'month', 'day' (override with `.groups` argument)

weather_most_delayed <- semi_join(weather, worst_hours, 
                                  by = c("origin", "year",
                                         "month", "day", "hour"))

select(weather_most_delayed, temp, wind_speed, precip) %>%
  print(n = 48)


# 5- What does anti_join(flights, airports, by = c("dest" = "faa")) tell you? 
# What does anti_join(airports, flights, by = c("faa" = "dest")) tell you?

# Answer: returns the flights that went to an airport that is not in the FAA list of destinations. 
# Since the FAA list only contains domestic airports, these are likely foreign flights
anti_join(flights, airports, by = c("dest" = "faa")) %>% 
  distinct(dest)

# Answer: returns the US airports that were not the destination of any flight in the data. 
# Since the data contains all flights from New York City airports, this is also the list of US airports that did not
# have a nonstop flight from New York City in 2013.
anti_join(airports, flights, by = c("faa" = "dest"))

# 6- You might expect that there’s an implicit relationship between plane and airline, 
# because each plane is flown by a single airline. Confirm or reject this hypothesis using the tools you’ve learned above.

# return us 
planes_carriers <-
  flights %>%
  filter(!is.na(tailnum)) %>%
  distinct(tailnum, carrier)

# The number of planes that have flown for more than one airline are those tailnum that appear
# more than once in the planes_carriers data.

planes_carriers %>%
  count(tailnum) %>%
  filter(n > 1) %>%
  nrow()
#> [1] 17




