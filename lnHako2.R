library(rvest)
library(dplyr)
library(xlsx)
library(stringr)
#library(tidyverse)

getPublisher = function(x) {
  novelPage = read_html(x)
  publisher = novelPage %>% html_nodes(".publisher-name a") %>% html_text()
  return(publisher)
}

#Create Data Frame to Contain value
lnBook = data.frame()
lnArtist = data.frame()
lnPublishers = data.frame()
lnImgSrc = data.frame()

for (pageResult in 2 : 3){
  print(paste("Scrapping Page:", pageResult))
  
  link = paste0("https://ln.hako.re/xuat-ban?page=", pageResult)
  page = read_html(link)
  
  bookLinks = page %>% html_nodes(".series-name") %>% html_attr("href")

  titles = page %>% html_nodes(".series-name") %>% html_text()
  description = page %>% html_nodes(".series-summary") %>% html_text()
  artists = page %>% html_nodes("#licensed-list .col-md-6:nth-child(2) a") %>% html_text()
  authors = page %>% html_nodes("#licensed-list .col-md-6:nth-child(1) a") %>% html_text()
  publishers = sapply(bookLinks, FUN = getPublisher, USE.NAMES = FALSE)
  
  imgSource <- page %>% html_nodes("#licensed-list .img-in-ratio") %>% html_attr('style')
  imgSource <- str_sub(imgSource, 24, -3)
  lnImgSrc = rbind(lnImgSrc, data.frame(imgSource, stringsAsFactors = FALSE))
  
  imgName <- str_sub(imgSource, 38)
  imgName <- paste0("CuoiKy\\HakoImg\\", imgName)
  
  lnBook = rbind(lnBook, data.frame(titles, description, artists, authors, publishers, imgName, stringsAsFactors = FALSE))
  lnPublishers = rbind(lnPublishers, data.frame(publishers, stringsAsFactors = FALSE))
  lnArtist = rbind(lnArtist, data.frame(artists, stringsAsFactors = FALSE))
  
  print(paste("Scrapped Page:", pageResult))
}
print("Done!")

#Remove duplicated
lnPublishers = lnPublishers %>% distinct(publishers, .keep_all = TRUE)
lnArtist = lnArtist %>% distinct(artists, .keep_all = TRUE)

#Create ID
BookID <- paste0("BOOK",seq.int(nrow(lnBook)))
publisherID <- paste0("PUB",seq.int(nrow(lnPublishers)))
artistID <- paste0("ART",seq.int(nrow(lnArtist)))

#Combine the data frame with ID
book = data.frame(BookID, lnBook)
publisher = data.frame(publisherID, lnPublishers)
artist = data.frame(artistID, lnArtist)

#Add ID from publishers and artists to book
book$publisherID <- publisher$publisherID[match(book$publishers, publisher$publishers)];
book$artistID <- artist$artistID[match(book$artists, artist$artists)];

#Write to Excel
write.xlsx(book, "lnHako.xlsx", sheetName = "book", col.names = TRUE, append = FALSE)
write.xlsx(publisher, "lnHako.xlsx", sheetName = "publishers", col.names = TRUE, append = TRUE)
write.xlsx(artist, "lnHako.xlsx", sheetName = "artists", col.names = TRUE, append = TRUE)

#downLoad the Url Img
for (num in 1:length(lnImgSrc[[1]])) {
  temp = lnImgSrc[[1]][num]
  imgName = str_sub(temp, 38)
  cat("Dowloading image: ", imgName, "\n")
  imgName = paste0("CuoiKy\\HakoImg\\", imgName)
  download.file(temp, destfile = imgName, mode="wb") 
}