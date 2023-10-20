salaries <-read.csv('C:\\Users\\sofia\\Downloads\\Hw 2 Dataset\\2017-18_NBA_salary.csv')
###############Prob1################

# Who is the highest paid NBA player and what is his team, draft number, minutes 
#played (MP), and true shooting percentage (TS%)?
highest_player<-salaries[70, ]
cat("Highest Paid NBA Player is: ", highest_player$Player, "\n","Team: ", highest_player$Tm, "\n", "Salary: ", highest_player$Salary, "\n", "Draft Number: ", highest_player$NBA_DraftNumber, "\n","Minutes Played: ", highest_player$MP, "\n","True Shooting Percentage: ", highest_player$TS., "\n\n\n")

#What is the minimum, maximum, and average salaries of NBA players?
cat("Minimum Salary: ", min(salaries$Salary), "\n", "Maximum Salary: ", max(salaries$Salary), "\n", "Average Salary: ", mean(salaries$Salary), "\n\n")

#: What is the minimum, maximum, and average ages of all the NBA players from USA
cat("Minimum Age: ",min(salaries$Age), "\n", "Maximum Age: ", max(salaries$Age), "\n", "Average Age: ", mean(salaries$Age), "\n\n\n")

# What is the minimum, maximum, and average ages of all the NBA players from USA
filtered_USA_salaries <- salaries %>% filter(salaries$NBA_Country == "USA")
cat("Minimum Age: ", min(filtered_USA_salaries$Age), "\n", "Maximum Age: ", max(filtered_USA_salaries$Age), "\n", "Average Age: ", mean(filtered_USA_salaries$Age))
 
#What is the minimum, maximum, and average ages of all the NBA non-USA players?
filtered_nonUSA_salaries <- salaries %>% filter(salaries$NBA_Country != "USA")
cat("Minimum Age: ",min(filtered_nonUSA_salaries$Age), "\n", "Maximum Age: ", max(filtered_nonUSA_salaries$Age), "\n", "Average Age: ", mean(filtered_nonUSA_salaries$Age))

###############Prob2################
#What is the average salary and average true shooting percentage (TS%) of the first NBA team?
ORL_info<-salaries %>%filter(NBA$Tm == "ORL")
cat("The average salary in Orlando Magic is: $", mean(ORL_info$Salary), "\n", "The True Shooting Percentage is: ", mean(ORL_info$TS.))

#What is the average salary and average true shooting percentage (TS%) of the second NBA team?
MIA_info<-salariesMIA_AVE_AGE<-mean(MIA_info$Age)
cat("The average salary in Miami Heat is: $", mean(MIA_info$Salary), "\n", "The True Shooting Percentage is: ", mean(MIA_info$TS.))

#Print a table that compares the average age, salaries and true shooting percentages (TS%) of the two teams in tabular form as follows:
MIA_AVE_AGE<-mean(MIA_info$Age)
ORL_AVE_AGE<-mean(ORL_info$Age)
ORL_AVE_SAL<-mean(ORL_info$Salary)
MIA_AVE_SAL<-mean(MIA_info$Salary)
mytable<-data.frame("Teams" = c("MIA", "ORL"), "Age"=c(MIA_AVE_AGE, ORL_AVE_AGE), "Average Salary" = c(MIA_AVE_SAL, ORL_AVE_SAL))
print(mytable)

###############Prob3################
#How many flights went from New York to Fort Lauderdale (FLL) in 2013?
NY_FLL_2013<-count(filter(flights, dest == 'FLL'))
cat("There were ", NY_FLL_2013$n, " flights that went from New York to Fort Lauderdale in 2013")

#How many flights went from New York (JFK) to Fort Lauderdale (FLL) in 2013?
JFK_FLL_2013<-count(filter(flights, dest == 'FLL', origin == 'JFK'))
cat("There were ", JFK_FLL_2013$n, " flights that went from New York (JFK) to Fort Lauderdale in 2013")

#How many flights went from New York (LGA) to Fort Lauderdale (FLL) in 2013?
LGA_FLL_2013<-count(filter(flights, dest == 'FLL', origin == 'LGA'))
cat("There were ", LGA_FLL_2013$n, " flights that went from New York (LGA) to Fort Lauderdale in 2013")

#How many flights went from New York (EWR) to Fort Lauderdale (FLL) in 2013?
EWR_FLL_2013<-count(filter(flights, dest == 'FLL', origin == 'EWR'))
cat("There were ", EWR_FLL_2013$n, " flights that went from New York (EWR) to Fort Lauderdale in 2013")

###############Prob4################
#How many different countries are represented by NBA players?
country_Number<-table(salaries$NBA_Country)
length(country_Number)

#Print a list of all the countries represented by NBA players and the number of players 
#from each country
print(country_Number)

#Generate a horizontal geom-bar plot of countries and number of NBA players.
ggplot(country_counts,aes(x= Players, y= NBA_Country))+ geom_bar(stat = "identity", fill="blue")+labs(title = "NBA Players Represented by Country", x = "Countries", y = "Frequency")
