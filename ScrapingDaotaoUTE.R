library(rvest)
library(dplyr)
library(readr)

link = "https://ln.hako.re/xuat-ban"
page = read_html(link)
bookLinks = page %>% html_nodes(".series-name") %>% html_attr("href")

titles = page %>% html_nodes(".series-name") %>% html_text()
description = page %>% html_nodes(".series-summary") %>% html_text()

getPublisher = function(x) {
  novelPage = read_html(x)
  publisher = novelPage %>% html_nodes(".publisher-name a") %>% html_text()
  return(publisher)
}

getAuthor = function(x) {
  novelPage = read_html(x)
  author = novelPage %>% html_nodes(".col-xl-4:nth-child(1) .info-value a") %>% html_text()
  return(author)
}

getArtist = function(x) {
  novelPage = read_html(x)
  artist = novelPage %>% html_nodes(".col-xl-4:nth-child(2) .info-value a") %>% html_text()
  return(artist)
}

publishers = sapply(bookLinks, FUN = getPublisher)
authors = sapply(bookLinks, FUN = getAuthor)
artists = sapply(bookLinks, FUN = getArtist)

lnHako = data.frame(titles, description, publishers, authors, artists, stringsAsFactors = FALSE)
write_excel_csv(lnHako, "lnHako.csv")