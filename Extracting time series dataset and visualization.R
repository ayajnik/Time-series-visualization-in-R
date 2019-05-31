library(ggplot2)
library(plyr)
library(reshape)
library(tseries)
library(gridExtra)
library(RColorBrewer)
install.packages('maps')
library(maps)
install.packages('mapproj')
library(mapproj)
install.packages('ggmap')
library(ggmap)
library(vcd)
install.packages('aplpack')
library(aplpack)
install.packages('ggparallel')
library(ggparallel)
install.packages('lubridate')
library(lubridate)
#downloading the dataset
google <- get.hist.quote(
  "goog",start = "2012-1-1",end = "2013-1-1", quote = c("Open"))
head(google)
str(google)
#basic pre-processing
google <- as.data.frame(google)
head(google)
str(google)
#extracting the names of the rows
names <-row.names(google)
head(names)
str(names)
#changing from characters date representation to actual date representation
#year/month/date
dates <- ymd(row.names(google))
head(dates)
#adding a new column with dates
#creating a new column with the date value of the rows
google <- transform(google, date = dates)
head(google)
#plotting the data
ggplot(data=google) + geom_line(aes(x = date, y = Open))
#area graph
ggplot(data = google) + geom_area(aes(x = date, y = Open))
#plotting multiple time-series
amazon <-as.data.frame(get.hist.quote("amzn",start = "2012-1-1",end = "2013-1-1",quote = c("Open")))
amazon <-transform(amazon, date=ymd(row.names(amazon)))
amazon <- transform(amazon,comapny="amazon")
#add the name of the series to google
google <- transform(google,company = "google")
#append rows to a dataframe
combined <-rbind(google,amazon)
ggplot(data=combined)+geom_line(aes(x=date,y=Open,colour=company))
