# zomato scraper
A simple r program using rvest package to fetch(harvest) top restaurants in Bangalore based on Ratings on Zomato.

rvest package has been installed to fetch all the required data present in the zomato website - https://www.zomato.com/bangalore/best-restaurants

In the above website the restaurants are ordered on the basis of thier rating.

In the website point of interest was restaurant name, rating, votes, cuisines served, address, costs for two.

Using css selectors and xpath fetched the required information.

Later cleaned the data using gsub and trimws in base r



