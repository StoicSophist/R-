#----------------Procedure 1----------------

#How many different New York airports does your dataset contain and which one is the busiest of them? 
flights_nyc_2013<-nycflights13::flights
    #adding the dplyr library makes it easier to get the unique values of the set.
library(dplyr)
NYC_airports<-n_distinct(flights_nyc_2013$origin)
cat("There are ", NYC_airports, "airports in New York in this dataset.")

flights_nyc_2013 %>%
  count(origin) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  pull(origin) ->busiest
cat("The busiest airport in New York is", busiest)

#How many different destination airports does your dataset contain and what is the most popular destination (airport code)?
Dest_unique<-n_distinct(flights_nyc_2013$dest)
cat("There are", Dest_unique, "many different destinations that travlers have gone to from New York airports.")

flights_nyc_2013 %>%
  count(dest) %>%
  arrange(desc(n)) %>%
  slice(1) %>%
  pull(dest) ->most_popular_des
cat("The most popular airport destination is", most_popular_des, "from New York airports.")


#How many flights departed from LGA on July 4, 2013?
july<-filter(flights_nyc_2013, origin=="LGA", month==7, day==4)
amount_july<-length(july$day)
cat("There are", amount_july, "flights that departed from LGA on July 4, 2013")


#What was the busiest day of the year?
date_j<-flights_nyc_2013$day
day_table<- table(date_j)
most_pop<-names(day_table[which.max(day_table)])
cat("The busiest day of the year is", most_pop)

#What was the busiest month of the year?
month_data<-flights_nyc_2013$month
month_table<-table(month_data)
most_pop_month<-names(month_table[which.max(month_table)])
cat("The busiest month of the year is", most_pop_month)


#What is the longest flight in the dataset? 
long<- flights_nyc_2013 %>% filter(distance == max(distance)) %>% arrange(desc(distance)) %>% head(1)
cat("The longest flight distance wise is", long$distance)


#What is the shortest flight in the dataset?
short<- flights_nyc_2013 %>% filter(distance == min(distance)) %>% arrange(distance)
cat("The shortest flight distance wise is", short$distance)


#Which carrier had the largest number of flights?
flights_nyc_2013 %>% count(carrier) %>% arrange(desc(n)) %>% slice(1) %>% pull(carrier) ->most_popular_carrier
cat("The most popular carrier is", most_popular_carrier,".")

#Which destination (airport code) had the shortest average arr_delay?

#[Enter a new meaningful question of your choice here] 
#---------------MAKE QUESTION--------------------


#----------------Procedure 2----------------

library(ggplot2)
#PLOT 1: Total number of departures per month per departure airport (“origin”) [line plot?]
# Extract the month from the 'time_hour' column
flights_nyc_2013 <- flights_nyc_2013 %>%
  mutate(month = lubridate::month(time_hour))

departures_per_month <- flights_nyc_2013 %>%
  group_by(origin, month) %>%
  summarize(total_departures = n())

ggplot(data = departures_per_month, aes(x = month, y = total_departures, group = origin, color = origin)) +
  geom_line() +
  labs(
    title = "Total Number of Departures per Month per Departure Airport",
    x = "Month",
    y = "Total Departures"
  ) +
  scale_color_discrete(name = "Origin") +
  theme_minimal()

#PLOT 2: Average departure delay for flights departing from JFK per month [line plot?]
jfk_flights <- flights_nyc_2013 %>%
  filter(origin == "JFK")

jfk_flights <- jfk_flights %>%
  mutate(month = lubridate::month(time_hour))

avg_dep_delay_per_month <- jfk_flights %>%
  group_by(month) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE))

ggplot(data = avg_dep_delay_per_month, aes(x = month, y = avg_dep_delay)) +
  geom_line() +
  labs(
    title = "Average Departure Delay for JFK Flights per Month",
    x = "Month",
    y = "Average Departure Delay (minutes)"
  ) +
  theme_minimal()

#PLOT 3: Total number of flights per airline/carrier [bar plot?] [pie chart?]
flight_counts <- flights_nyc_2013 %>%
       group_by(carrier) %>%
       summarize(total_flights = n())

ggplot(data = flight_counts, aes(x = carrier, y = total_flights)) +
       geom_bar(stat = "identity", fill = "blue") +
       labs(title = "Total Number of Flights per Airline/Carrier", x = "Airline/Carrier", y = "Total Flights") +
       theme_minimal()

#PLOT 4: Statistical distribution of departure delays for the 5 busiest carriers [box plot?] [violin plot?]
carrier_counts <- flights_nyc_2013 %>%
     group_by(carrier) %>%
    summarize(total_flights = n()) %>%
    arrange(desc(total_flights)) %>%
    head(5)

flights_busiest_carriers <- flights_nyc_2013 %>%
     filter(carrier %in% carrier_counts$carrier)

ggplot(data = flights_busiest_carriers, aes(x = carrier, y = dep_delay)) +
     geom_violin(fill = "blue", alpha = 0.6) +
     labs(title = "Statistical Distribution of Departure Delays for the 5 Busiest Carriers", x = "Carrier", y = "Departure Delay (minutes)") +
     theme_minimal()
#PLOT 5: Total number of flights with departure delay greater than 2 hours per month [bar plot?]
delayed_flights <- flights_nyc_2013 %>%
  filter(dep_delay > 120)

delayed_flights <- delayed_flights %>%
  mutate(month = as.Date(time_hour) %>% lubridate::month(label = TRUE))

delayed_flights_per_month <- delayed_flights %>%
  group_by(month) %>%
  summarize(total_delayed_flights = n())

ggplot(data = delayed_flights_per_month, aes(x = month, y = total_delayed_flights)) +
  geom_bar(stat = "identity", fill = "red") +
  labs(title = "Total Number of Flights with Departure Delay > 2 Hours per Month", x = "Month", y = "Total Delayed Flights") +
  theme_minimal()


#-------------OPTIONAL Procedure 3-------------

#BONUS QUESTION 1: Which airline had the shortest average delay per flight? 
  #(Hint: use a new column/variable gain = dep_delay - arr_delay to answer this question and the next)

#BONUS QUESTION 2: Which airline had the longest average delay per flight? 

#BONUS QUESTION 3: What was the worst day of the year (i.e., longest average dep_delay) to catch a flight from JFK?

#BONUS QUESTION 4: What percentage of flights departing from JFK had a delay of less than 10% of the total flight time? 

#BONUS QUESTION 5: Which airline had the shortest number of flights delayed by more than 2 hours between May and September?
  