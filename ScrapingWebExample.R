#install.packages("rvest")
#install.packages("dplyr")
#install.packages("readr")
library(rvest)
library(dplyr)
library(readr)

# %>% equivalent statements
# a %>% mean() = mean(a)
link = "https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=adventure&sort=user_rating,desc"
page = read_html(link)
movie_links = page %>% html_nodes(".lister-item-header a") %>%
  html_attr("href") %>% paste("https://www.imdb.com", ., sep="")

name = page %>% html_nodes(".lister-item-header a") %>% html_text()
year = page %>% html_nodes(".text-muted.unbold") %>% html_text()
rating = page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
synopsis = page %>% html_nodes(".ratings-bar+ .text-muted") %>% html_text()

movies = data.frame(name, year, rating, synopsis, stringsAsFactors = FALSE)
write_excel_csv(movies, "movies.csv")