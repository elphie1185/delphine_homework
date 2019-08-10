library(CodeClanData)
library(tidyverse)
library(lubridate)

IBM_agents <- separate(IBM_stock_price, 
                       Agents,
                       c("agent1", "agent2"), 
                       sep = "/", 
                       remove = FALSE)
IBM_agent_data_first <- unite(IBM_agents, 
                              agent1, 
                              c("agent1", "ID1"), 
                              sep = ":")
IBM_agent_data <- unite(IBM_agent_data_first, 
                        agent2, 
                        c("agent2", "ID2"), 
                        sep = ":")
JNJ_stock_price_gathered <- gather(JNJ_stock_price, 
                                   date, 
                                   jnj_open)
IBM_data <- select(IBM_agent_data, date, open)
open_stock_data <- full_join(JNJ_stock_price_gathered, IBM_data, 
                             by = "date")


#using map and $
open_stock_data$new_date <- map(open_stock_data$date, dmy)

#you'll see that it's a list of dates, so because mapping is designed for lists 
open_stock_data
class(open_stock_data[[4]])
#equivalent to class(open_stock_data$new_date)

#if hadn't assign to new column in this way would get correct format
class(map(open_stock_data$date, dmy)[[1]])

#So if using map to create a new column might be an idea to use tidyverse (to get consistent formatting)
open_stock_data2<- open_stock_data %>%
                    mutate(new_date = dmy(date))

open_stock_data2<- open_stock_data %>%
                      select(date) %>%
                      map(dmy)
#not so obvious way as if using tibble would likely use mutate(new_date = dmy(date))

----------------------------------------

#Method 1
start.time <- Sys.time()

-----
var_length_vect <- c()
for(i in 1:ncol(open_stock_data)){
  var_name <- colnames(open_stock_data[, i]) #would change this to colnames(open_stock_data)[i]
  var_length <- nrow(open_stock_data[, i]) #would change this to nrow(open_stock_data)[i]
  var_length_vect <- c(var_length_vect, var_name, var_length)
}

var_length_data <- matrix(var_length_vect, ncol = 2, byrow = TRUE)
colnames(var_length_data) <- c("Variable", "Variable length")
var_length_data
-----
  
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
#0.011307 secs 


#Method 2
start.time <- Sys.time()

-----
var_length_data<- NULL
  
for (i in 1:ncol(open_stock_data)) {
  
  var_length_data[i]<-typeof(open_stock_data[[i]])
}
-----

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
#0.006972075 secs

# Method 3
start.time <- Sys.time()

-----
var_length_data<- data.frame()

for (i in 1:ncol(open_stock_data)) {
  
  var_length_data[i,1]<-colnames(open_stock_data)[i]
  var_length_data[i,2]<-typeof(open_stock_data[[i]])
}
-----

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
#0.009181023 secs

