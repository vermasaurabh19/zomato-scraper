#loading packages
library(rvest)
library(stringr)
library(tidyr)

#Specifying the url for desired website to be scrapped
url <- 'https://www.zomato.com/bangalore/best-restaurants'

#Reading the HTML code from the website
webpage <- read_html(url)

#Using CSS selectors to scrap the title section
title_html <- webpage %>%  
                html_nodes('a.result-title') %>% 
                  html_text()

#scrap the rating section
rating_html <- webpage %>% 
                html_nodes('div.rating-popup') %>% 
                html_text()


#scrap the address of the restaurant
address_html <- webpage %>% 
                html_nodes('div.search-result-address') %>% 
                html_text()

#scrap the votes received by the restaurant
votes_html <- webpage %>% 
                 html_nodes(xpath = '//*[@id="orig-search-list"]/div/div[1]/div/article/div[1]/div/div[2]/div[1]/div[2]/span') %>% 
                 html_text()


#scrap the average cost for two person 
cost_html <- webpage %>% 
                  html_nodes('div.res-cost > span.pl0') %>% 
                  html_text()

#scrap the cuisine availbale in retaurant
cuisine_html <- webpage %>% 
              html_nodes('span.nowrap') %>% 
             html_text()


#cuisine_html <- webpage %>% 
          #  html_nodes(xpath = '//*[@id="orig-search-list"]/div/div[1]/div/article/div[3]/div[1]/span[2]') %>% 
           # html_text()


#Combining all the extractions made
top_restaurant <- cbind(restaurant = title_html,
                    rating = rating_html,
                  votes = votes_html,
                    cuisine = cuisine_html,
                    cost_for_two = cost_html,
                  address = address_html)

#converting into data frame
top_restaurant <- as.data.frame(top_restaurant)

#adding ranking column in the df
top_restaurant$ranking <- 1:nrow(top_restaurant)

top_restaurant<- top_restaurant[,c(7,1,2,3,4,5,6)]


##cleaning top_restaurant data

top_restaurant$rating <- trimws(top_restaurant$rating)

top_restaurant$restaurant <- trimws(top_restaurant$restaurant)

top_restaurant$votes <- gsub(' votes','',top_restaurant$votes)

top_restaurant$cost_for_two <- gsub("\u20b9","",top_restaurant$cost_for_two)

#Saving as output
write.csv(top_restaurant,'C:/Users/vermas22/Desktop/Consulting/Self Training/top restaurant.csv',row.names = FALSE)
